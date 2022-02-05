module ApplicationHelper
  def auth?
    @current_user.present?
  end
end
