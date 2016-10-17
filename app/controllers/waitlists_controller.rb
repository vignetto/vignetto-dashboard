class WaitlistsController < ApplicationController

  def get_on_waitlist
    event = Event.find(params[:event_id])
    waitlist = (Waitlist.where(event_date_id: params[:event_date_id])).first
    unless waitlist.nil?
      event_date = waitlist.event_date 
      info = event_date.nil? || waitlist.event.waitlist_only? ? "." : " for #{event_date.get_event_duration_format}."
    end
    user = User.find(params[:user_id]) unless params[:user_id].blank?
    passed = !(waitlist.nil? || user.nil?)
    if user_signed_in?
      if !passed
        flash[:info] = "Something went wrong. Was not able to add you to the waitlist."
      elsif passed && waitlist.user_waitlisted?(user)
        flash[:info] = "You are already on the waitlist" << info
      elsif passed && waitlist.full_waitlist?
        flash[:info] = "Waitlist is already full!"
      else
        if authorize(waitlist, :get_on_waitlist?)
          waitlist.add_user_to_waitlist(user.email)
          flash[:notice] = "You have been added to the waitlist" << info
        end
      end
      redirect_to :back
    else  
      store_location(url_for(event)) if event
      flash[:info] = "You must log in or create a free account to get on the waitlist."
      redirect_to new_user_registration_path and return
    end
  end
end
