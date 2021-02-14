class SessionsController < ApplicationController
  before_action :valid_params?, only: [:create]

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      log_in(@user)
      redirect_to action: :index
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render action: :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def valid_params?
    if login_params[:email].blank? || login_params[:password].blank?
      binding.pry
      redirect_to root_url
    end
  end
end
