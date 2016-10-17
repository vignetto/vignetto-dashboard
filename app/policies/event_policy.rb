class EventPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  	def resolve
      if user.admin?
        scope.all
      else 
        scope.where(user_id: user.id)
    	end 
    end
  end

  def user_not_logged_in?
    current_user.nil?
  end

  def user_logged_in?
    !current_user.nil?
  end

  def host_of_event?
    user_logged_in? && host? && model.user_id == current_user.id
  end

  def participant?
    user_logged_in? && current_user.participant?
  end

  def admin?
    user_logged_in? && current_user.admin?
  end

  def index?
    admin?
  end

  def create?
    model && (admin? || host?)
  end  

  def new?
    create?
  end

  def show?
    model && ( ( (user_not_logged_in? || participant?) && model.publish) || admin? || host_of_event? )
  end

  def update?
    model && (admin? || host_of_event? )
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def destroy_all?
    admin?
  end

  def delete?
    destroy?
  end

  def buy_tickets?
    model && (admin? || ((host? || participant?) && model.publish) )
  end
end
