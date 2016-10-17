class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :event_date

  after_save :update_tickets_sold_count

  validates :user_id, :event_id, :event_date_id, :tickets, :full_name, :address, :city, :state, :zipcode, presence: true, allow_blank: false

  def process_payment
    charge = create_charge    
    set_from_stripe_response(charge) unless charge.nil?
    charge.nil? ? false : true
  end

  def get_amount_to_currency
    to_currency(amount)
  end

  def to_currency(amount)
    "$#{sprintf( "%0.02f", amount)}"
  end

  private
  # Populate this payment with Stripes response attributes
  def set_from_stripe_response(charge)  
    self.stripe_charge_id = charge.id 
    retreive_charge = JSON.parse(Stripe::Charge.retrieve(stripe_charge_id).to_s)
    self.status = retreive_charge['status']
    self.paid = retreive_charge['paid']
    self.amount = retreive_charge['amount']/100
    self.card_brand = retreive_charge['source']['brand']
    self.card_four = retreive_charge['source']['last4']
    self.card_exp = "#{retreive_charge['source']['exp_month']}/#{retreive_charge['source']['exp_year']}"
    self.description = retreive_charge['description']
    self.statement_descriptor = retreive_charge['statement_descriptor']
    self.ticket_price = event.ticket_price
  end

  # Create Stripe Charge object
  def create_charge
    card_declined = false
    begin
      charge = Stripe::Charge.create( 
        source: card_token,
        amount: event.get_stripe_ticket_price * tickets,
        description: event_date.get_payment_desc_format,
        statement_descriptor: "#{tickets} tickets @$#{sprintf( "%0.02f", event.ticket_price)}",
        currency: 'usd',
        receipt_email: stripe_email,
        metadata: { vignetto_user_id: user.id, 
                    event_id: event_id, 
                    tickets: tickets, 
                    price: event.ticket_price, 
                    event_date: "#{event_date.get_event_and_event_date_format}",
                    email: stripe_email }
      )
    rescue Stripe::CardError => e
      errors.add(:base, 'Your card was declined!') if e.to_s.include?('Your card was declined')
      nil
    rescue Stripe::InvalidRequestError => e
      errors.add(:base, 'Request error!')
      nil
    rescue => e
      nil
    end
  end

  def update_tickets_sold_count
    event_date.update_attribute(:tickets_sold, event_date.tickets_sold + tickets) 
  end
end