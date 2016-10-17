class ApplicationController < ActionController::Base
  include Pundit
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def redirect_to_back
    redirect_to(session[:forwarding_url])
    delete_location
  end

  def store_location(location=nil)
    if location
      session[:forwarding_url] = location
    else 
      session[:forwarding_url] = request.url if request.get?
    end
  end

  def location_stored?
    !session[:forwarding_url].nil?
  end

  def delete_location
    session.delete(:forwarding_url) if location_stored?
  end

  def after_sign_in_path_for(resource)
    req = if session[:forwarding_url]
      session[:forwarding_url]
    else 
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
    delete_location
    req
  end

  private 

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    if user_signed_in?
      redirect_to account_path
    else
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password, :address, :city, :state, :zipcode, :phone)
    }
  end

  def authenticate_admin_user!
    authenticate_user! 
    unless current_user.admin?
      flash[:alert] = "This area is restricted to administrators only."
      redirect_to root_path 
    end
  end
   
  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end
end
