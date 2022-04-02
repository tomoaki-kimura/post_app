class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private
  
  def require_admin_logged_in
    redirect_to root_url unless current_user&.admin?
  end
  
  def require_user_logged_in
    redirect_to root_url unless logged_in?
  end
end