class PromotionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # if user.admin?
        scope.all
      # else
        # scope.where(user: user)
      # end	
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def new?
    @user == user || user.admin
  end

  def create?
    @user == user || user.admin
  end

  def update?
    user.admin
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin  
  end
end