class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_team, :current_team_user

  def current_team
    @_current_team ||= current_user.teams.find_by(id: session[:team_id]) if session[:team_id].present?
  end

  def current_team_user
    return unless current_team
    @_current_team_user ||= current_team.team_users.find_by(user: current_user)
  end

  def current_team_user_admin?
    return false unless current_team_user
    current_team_user.role == "admin"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end
