class ApplicationController < ActionController::Base

  before_action :find_user_or_redirect

  private

  def find_user_or_redirect
    @current_user = User.find_by_id(session[:user_id])
    unless @current_user
      session[:user_id] = nil
      redirect_to login_path if params[:controller] != 'auth' && params[:action] != 'login'
    end
  end
end
