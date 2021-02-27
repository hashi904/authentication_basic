require 'rails_helper'

describe JwtAuthentication do
  controller Api::ApiApplicationController do
    include JwtAuthentication
  end

  describe '.create_jwt' do
    let!(:preload_user) { { nicknname: 'test', email: 'test@gmail.com' } }
    let!(:jwt) { 'eyJhbGciOiJIUzI1NiJ9.eyJwcmVsb2FkIjoiaG9nZSIsImV4cCI6MTYxMzc5NzU3OX0.JzN6FcpLNWDnap0c2QWSY08c3oID6wwvijGYJ4VlbPU' }
    before do
      allow(Authentication::JwtAuthenticator).to receive(:encode).with(preload_user).and_return(jwt)
    end

    it 'return jwt' do
      expect(controller.create_jwt(preload_user)).to eq(jwt)
    end
  end

  describe '.jwt_authenticate' do
    subject { controller.jwt_authenticate }
    context 'success' do
      before do
        allow(Authentication::JwtAuthenticator).to receive(:decode).with(jwt).and_return(user)
        request.headers['authorization'] = jwt
      end
      let!(:jwt) { 'eyJhbGciOiJIUzI1NiJ9.eyJwcmVsb2FkIjoiaG9nZSIsImV4cCI6MTYxMzc5NzU3OX0.JzN6FcpLNWDnap0c2QWSY08c3oID6wwvijGYJ4VlbPU' }
      let!(:user) { { 'email' => 'test@gmail.com', 'nickname' => 'test' } }

      it 'return user' do
        is_expected.to eq(user)
      end
    end
  end
end
