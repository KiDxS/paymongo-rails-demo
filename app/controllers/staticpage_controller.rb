class StaticpageController < ApplicationController
  before_action :authenticate_user!
  before_action :if_user_has_not_paid_yet
  def index
  end
end
