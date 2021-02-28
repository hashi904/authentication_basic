class AdminsController < ApplicationController
  before_action :login_check
  def index
    @users = User.all
  end
end
