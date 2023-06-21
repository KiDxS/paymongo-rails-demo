class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:index]
  def redirect_paid_users
    redirect_to root_path if user_paid?
  end
  def user_paid?
    current_user.paid == true
  end
  def redirect_unpaid_users
    redirect_to access_page_path if user_paid?    
  end
end
