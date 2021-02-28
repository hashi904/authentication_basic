require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe 'POST #sign_in' do
    let!(:sign_in_params) do
      {
        email: email,
        password: password
      }
    end

    context 'Sign inに成功する時' do
      let!(:email) { 'test@gmail.com' }
      let!(:password) { 'testtest' }

      it 'http status 200' do
        post :sign_in, params: sign_in_params, xhr: true
        expect(response.status).to eq 200
      end
    end

    context 'Sign inに失敗する時' do
      context 'emailが間違っている時' do
        let!(:email) { 'hoge@gmail.com' }
        let!(:password) { 'testtest' }
        it 'http status 401' do
          post :sign_in, params: sign_in_params, xhr: true
          expect(response.status).to eq 401
        end
      end

      context 'passwordが間違っている時' do
        let!(:email) { 'test@gmail.com' }
        let!(:password) { 'no_password' }
        it 'http status 401' do
          post :sign_in, params: sign_in_params, xhr: true
          expect(response.status).to eq 401
        end
      end
    end
  end
end
