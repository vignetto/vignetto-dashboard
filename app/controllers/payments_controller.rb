class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @payment = Payment.new payment_params
    if @payment.valid? && authorize(@payment, :create?)
      if @payment.process_payment
        redirect_to payment_path(@payment), notice: "Payment was successful for #{@payment.event_date.get_payment_desc_format}" if @payment.save
      else 
        flash[:error] = "Please, check card information errors. #{@payment.errors.full_messages.join(', ')}"
        redirect_to :back  
      end
    else
      flash[:error] = "Something went wrong, you were not charged. Please, check errors. #{@payment.errors.full_messages.join(', ')}"
      redirect_to :back
    end
  end

  def show
    @payment = Payment.find(params[:id])
  end

  private
  def payment_params
    params.require(:payment).permit(
      :user_id, 
      :event_id, 
      :event_date_id, 
      :tickets, 
      :full_name, 
      :amount, 
      :stripe_charge_id, 
      :stripe_email, 
      :description, 
      :statement_descriptor, 
      :status, 
      :paid, 
      :card_brand, 
      :card_four,
      :card_token, 
      :address, 
      :city, 
      :state, 
      :zipcode )  
  end  
end


