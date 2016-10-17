class PaymentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  	def resolve
      if user.admin?
        scope.all
      else 
        scope.where(user_id: user.id)
    	end 
    end
  end
  
  def sold_out_or_on_waitlist
    model.event_date.tickets_sold_out? || 
    model.event_date.waitlist || 
    (model.event_date.tickets_sold_out? && model.event_date.waitlist)
  end

  def index?
    admin?
  end

  def create?
    model && (admin? || ((host? || participant?) && model.event.publish && !sold_out_or_on_waitlist) )
  end

  def new?
    create?
  end

  def show?
    model && (admin? || ((host? || participant?) && model.user_id == current_user.id) )
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
end
