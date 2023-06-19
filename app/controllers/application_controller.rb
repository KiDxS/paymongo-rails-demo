class ApplicationController < ActionController::Base
  def user_paid_yet?
    if current_user.paid == true
      true
    else
      false
    end
  end
end
