require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe 'POST #sign_in' do
    let!(:sign_in_params) do
      {
        email: email,
        password_digest: password_digest
      }
    end

    context 'Sign inに成功する時' do
      let!(:email) { 'test@gmail.com' }
      let!(:password_digest) { 'testtest' }

      it 'http status 200' do
        post :sign_in, params: { user: sign_in_params }, xhr: true
        expect(response.status).to eq 200
      end
    end

    context 'Sign inに失敗する時' do
      context 'emailが間違っている時' do
        let!(:email) { 'hoge@gmail.com' }
        let!(:password_digest) { 'testtest' }
        it 'http status 401' do
          post :sign_in, params: { user: sign_in_params }, xhr: true
          expect(response.status).to eq 401
        end
      end

      context 'passwordが間違っている時' do
        let!(:email) { 'test@gmail.com' }
        let!(:password_digest) { 'no_password' }
        it 'http status 401' do
          post :sign_in, params: { user: sign_in_params }, xhr: true
          expect(response.status).to eq 401
        end
      end
    end
  end
end
