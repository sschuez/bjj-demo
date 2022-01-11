class CompetitionAppointmentPolicy < ApplicationPolicy
	class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end	
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def show?
  	true
  end

  def create?
  	user == user || user.admin
  end

  def update?
  	record.user == user || user.admin
  end

  def destroy?
  	record.user == user || user.admin
  end
end