module JwtAuthentication
  extend ActiveSupport::Concern

  def create_jwt(preload_user)
    Authentication::JwtAuthenticator.encode(preload_user)
  end

  def jwt_authenticate
    raise_header_empty_error if request_header.blank?
    user = decode_jwt
    return raise_unauthoraization_error if user.nil?

    user
  end

  private

  def request_header
    request.headers['Authorization']
  end

  def jwt
    request_header.split('Bearer ').last
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

  def raise_header_empty_error
    render_401('http header token empty.')
  end

  def raise_unauthoraization_error
    render_401('Either you should be sign in or token is expired or wrong')
  end
end
