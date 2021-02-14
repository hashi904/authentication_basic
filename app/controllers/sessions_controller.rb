class SessionsController < ApplicationController
  def index; end

  def new
    @new_session = NewSessionForm.new
  end

  def create
    @new_session = NewSessionForm.new(login_params)

    if @new_session &&
       (@user = User.find_by(email: @new_session.email)) &&
       @user.authenticate(@new_session.password)
      log_in(@user)
      redirect_to action: :index
    else
      flash.now[:notice] = 'Invalid email or password'
      render action: :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_params
    params.require(:new_session_form).permit(:email, :password)
  end
end
