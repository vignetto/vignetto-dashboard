class EventDate < ActiveRecord::Base
  belongs_to  :event 
  has_many    :payments, inverse_of: :event_date

  before_validation :set_tickets_sold

  validates :time_begin, :time_end, :tickets_total, presence: true

  def get_hours_of_event
    time_begin - time_end
  end

  def get_event_and_event_date_format
  	"#{event.title} ( #{time_begin.strftime('%b %d, %Y')} #{time_begin.strftime('%I:%M%p')} - #{time_end.strftime('%I:%M%p')} )"
  end	

  def get_event_duration_format
  	"#{time_begin.strftime('%b %d, %Y')} ( #{time_begin.strftime('%I:%M%p')} -  #{time_end.strftime('%I:%M%p')} )"
  end	

  def get_payment_desc_format
    "#{event.title} ( #{time_begin.strftime('%b %d, %Y')} )"
  end 

  def tickets_sold_out?
    (tickets_total - tickets_sold) <= 0 
  end

  def get_tickets_left
    tickets_total - tickets_sold
  end

  def remove_waitlist
    update_attribute(:waitlist, false)
  end
  
  private
  def set_tickets_sold
  	self.tickets_sold = 0 if (tickets_sold.nil? || tickets_sold.blank?)
  end
end
