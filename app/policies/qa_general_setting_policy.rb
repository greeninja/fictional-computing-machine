class QaGeneralSettingPolicy < ApplicationPolicy
 attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @qa_general_setting = model
  end

  def edit?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def update?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def destroy?
    @current_user.admin? or
    @current_user.junior_admin?
  end

end
