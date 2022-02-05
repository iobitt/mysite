class ApplicationController < ActionController::Base

  before_action :find_user

  private

  def find_user
    @current_user = User.find_by_id(session[:user_id])
    session[:user_id] = nil unless @current_user
  end
end
