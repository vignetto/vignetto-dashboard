class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    delete_location
    @events = Event.where('package = ? AND publish = ?', false, true)
  end

  def show
    if authorize(@event, :show?)
      @event_months = @event.event_dates.order("time_begin ASC").group_by{|e| e.time_begin.beginning_of_month }
    else
      flash[:info] = "You are not authorized to view this page!"
      redirect_to :back and return
    end
    
  end

  def buy_tickets
    if user_signed_in? 
      set_event
      @payment = Payment.new
    else 
      store_location
      flash[:info] = "You must log in or create a free account to buy tickets"
      redirect_to new_user_registration_path and return
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params[:event]
    end
end
