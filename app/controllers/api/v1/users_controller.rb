class Api::V1::UsersController < Api::ApiApplicationController
  def sign_in
    user = User.find_by(email: sign_in_params[:email])
    if user.present? && user.authenticate(sign_in_params[:password_digest])
      render json: { status: 'login success' }
    elsif
      render_401('email or password invalid')
    end
  end

  private
  def sign_in_params
    params.require(:user).permit(:email, :password_digest)
  end
end
