class UsersController < ApplicationController
  def new
    @user = NewUserForm.new
  end

  def create
    @user = NewUserForm.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to sessions_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password)
  end
end
