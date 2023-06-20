class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:index]
  def dont_allow_paid_users_to_pay_again
    if current_user.paid == true
      redirect_to root_path
    end
  end
  def if_user_has_not_paid_yet
    redirect_to access_page_path unless current_user.paid == true
    
  end
end
