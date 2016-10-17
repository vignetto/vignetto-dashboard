class InquiriesController < ApplicationController

  def create
    @inquiry = Inquiry.new inquiry_params
    if @inquiry.save
      redirect_to root_path, notice: "Your inquiry has been sent to Vinetto!"
    else
      flash[:error] = "Please fix your submission."
      case @inquiry.request_type
      when 'generic'
        render 'visitors/contact_us'
      when 'to_be_host'
        render 'visitors/be_a_host'
      when 'private_event'
        render 'visitors/private_events'
      else
        redirect_to root_path
      end
    end
  end

  def inquiry_params
    params.require(:inquiry).permit(:first_name, :last_name, :email, :phone, :notes, :request_type)
  end
end
