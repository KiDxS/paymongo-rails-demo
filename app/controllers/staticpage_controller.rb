class StaticpageController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_unpaid_users
  def index
  end
end
