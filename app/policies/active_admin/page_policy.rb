module ActiveAdmin 
  class PagePolicy < ApplicationPolicy
    def index?
      admin?
    end

    def show?
      admin?
    end

    def update?
      admin?
    end

    def destroy?
      admin?
    end

    def create?
      admin?
    end

    def new?
      create?
    end

    def edit?
      update?
    end
  end
end
