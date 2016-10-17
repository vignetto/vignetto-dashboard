class WaitlistPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  	def resolve
      if user.admin?
        scope.all
      else 
        scope.none
    	end 
    end
  end
  
  def user_not_waitlisted 
    !model.user_waitlisted?(current_user)
  end

  def not_full
    !model.full_waitlist?
  end

  def index?
    admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def show?
    admin?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  def delete?
    destroy?
  end

  def destroy_all?
    admin?
  end

  def add_user?
    admin?
  end

  def get_on_waitlist?
    model && (admin? || ((host? || participant?) && user_not_waitlisted && not_full) )
  end
end
