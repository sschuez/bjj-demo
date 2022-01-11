class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # if user.admin?
      	scope.all #Anyone can view all users
      # else
      	# scope.where(user: user)
      # end	
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def show?
  	user_is_owner_or_admin?
  end

  def create?
  	true # Anyone can create a user.
  end

  def update?
  	user_is_owner_or_admin?
  end

  def destroy?
  	user_is_owner_or_admin?
  end

  def impersonate?
    user.admin
  end

  def stop_impersonating?
    true
  end

  private

  def user_is_owner_or_admin?
  	record == user || user.admin	
  end
  
end