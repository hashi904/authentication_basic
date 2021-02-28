class Api::V1::UsersController < Api::ApiApplicationController
  def sign_in
    @user = User.find_by(email: sign_in_params[:email])
    if @user.present? && @user.authenticate(sign_in_params[:password])
      jwt = create_jwt(user_preload)
      render json: { status: 'sign in success', jwt: jwt, user: user_preload }
    elsif
      render_401('email or password invalid')
    end
  end

  def sign_up
    @user = User.new(sign_up_params)
    if @user.save
      jwt = create_jwt(user_preload)
      render json: { status: 'sign up success', jwt: jwt, user: user_preload }
    else
      # todo jsonにエラーメッセージを追加したい
      render_401('sign up failed')
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def sign_up_params
    params.permit(:nickname, :email, :password)
  end

  def user_preload
    { email: @user.email, nickname: @user.nickname }
  end
end
