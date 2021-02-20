# only decode encode
module Authentication
  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  class JwtAuthenticator
    def self.encode(preload)
      payload = {
        preload: preload,
        exp: 1.hours.from_now.to_i
      }
      JWT.encode(payload, SECRET_KEY_BASE, 'HS256')
    end

    def self.decode(token)
      decoded_token = JWT.decode(token, SECRET_KEY_BASE, true, algorithm: 'HS256')
      decoded_token.first
    end
  end
end
