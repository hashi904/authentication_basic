module JwtAuthentication
  extend ActiveSupport::Concern

  def create_jwt(preload_user)
    Authentication::JwtAuthenticator.encode(preload_user)
  end

  # todo 有効チェック
  def check_jwt(token)
    Authentication::JwtAuthenticator.decode(token)
  end

  # 例外処理
end
