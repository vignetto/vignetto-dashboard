class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  	def resolve
      if user.admin?
        scope.all
      else 
        scope.none
    	end 
    end
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
    model && (admin? || model.id == current_user.id)
  end

  def update?
    model && (admin? || model.id == current_user.id)
  end

  def edit?
    update?
  end

  def destroy?
    model && admin? && (model.id != current_user.id) 
  end

  def delete?
    destroy?
  end

  def destroy_all?
    admin?
  end
end
