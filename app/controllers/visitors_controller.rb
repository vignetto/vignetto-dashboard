class VisitorsController < ApplicationController

  # Default landing
  def index
  end

  # Explore events
  def explore
  end


  # Detail packages
  def packages

  end

  #How it works
  def how_it_works

  end

  #Private events
  def private_events
  end

  #Sign up to be a host
  def be_a_host
  end

  def faq
  end

  def contact_us
  end

  def about_us
  end

  def in_the_news
  end

  def account
    unless user_signed_in?
      flash[:info] = "Not authorized! You must log in or create a free account."
      redirect_to new_user_session_path and return
    end    
  end
end
