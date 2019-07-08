class SpotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin?
  end

  def show?
    true
  end

  def update?
    user.admin? && record.user == user
  end

  def destroy?
    user.admin? && record.user == user
  end

end