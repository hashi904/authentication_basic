class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to sessions_path
    elsif
      # add error message
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password)
  end

  # todo create validate

end
