class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :find_mike

  protected

  def configure_permitted_parameters
  	 devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :update_without_password, :current_password, :bio, :image])
  	 devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :update_without_password, :current_password, :bio, :image])

  end

  private

  def find_mike
  	@mike = User.find_by_id(5)
  end

end
