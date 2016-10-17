class InquiryPolicy < ApplicationPolicy
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
    destroy?
  end
end
