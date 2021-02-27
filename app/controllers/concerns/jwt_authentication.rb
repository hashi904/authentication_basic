# request を想定した実装にしないと使い物にならなくない？
# tokenの取得方法を
module JwtAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :jwt_present?, only: [:jwt_authenticate]
  end

  def create_jwt(preload_user)
    Authentication::JwtAuthenticator.encode(preload_user)
  end

  def jwt_authenticate
    user = decode_jwt
    return unauthoraization_error if user.nil?

    user
  end

  private

  def jwt_present?
    render_401('http header token empty.') if jwt.blank?
  end

  def jwt
    request.headers['Authorization'].split('Bearer ').last
  end

  def decode_jwt
    body = Authentication::JwtAuthenticator.decode(jwt)
    HashWithIndifferentAccess.new body
  rescue JWT::VerificationError
    nil
  rescue JWT::ExpiredSignature
    nil
  rescue JWT::DecodeError
    nil
  end

  def unauthoraization_error
    render_401('Either you should be sign in or token is expired or wrong')
  end
end
