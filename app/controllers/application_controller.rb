class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def redirect_if_signed_in
    redirect_to root_path if current_user
  end

  def after_sign_in_path_for(resource)
    root_path
  end

end
