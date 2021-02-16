class UsersController < ApplicationController
  def new
    @form = NewUserForm.new
  end

  def create
    @form = NewUserForm.new(user_params)
    if @form.save?
      log_in(@form.user)
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
