class PackagesController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    delete_location
    @events = Event.where('package = ? AND publish = ?', true, true)
  end

  def show
    if authorize(@event, :show?)
      @event_months = @event.event_dates.order("time_begin ASC").group_by{|e| e.time_begin.beginning_of_month }
      @event_items = @event.event_items.order(:itinerary_begin);
    else
      flash[:info] = "You are not authorized to view this page!"
      redirect_to :back and return
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
