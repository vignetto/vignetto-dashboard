class ApplicationPolicy
  attr_reader :current_user, :model

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(id: user.id)
    end
  end

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def admin?
    current_user.admin?
  end

  def participant?
    current_user.participant?
  end

  def host?
    current_user.host?
  end

  def index?
    false
  end

  def show?
    false
  end

  def new?
    create?
  end

  def create?
    false
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def destroy_all?
    false
  end

end
