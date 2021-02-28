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

  describe 'POST #sign_up' do
    let!(:sign_up_params) do
      {
        nickname: nickname,
        email: email,
        password: password
      }
    end

    context 'sigin upに成功する時' do
      let!(:nickname) { 'sign_in_user' }
      let!(:email) { 'sign_in_user@gmail.com' }
      let!(:password) { 'sign_in_user_pass' }

      it 'return http response 200' do
        post :sign_up, params: sign_up_params, xhr: true
        expect(response.status).to eq 200
      end
    end

    context 'sigin upに失敗する時' do
      context 'nicknameが空の時' do
        let!(:nickname) { nil }
        let!(:email) { 'sign_in_user@gmail.com' }
        let!(:password) { 'sign_in_user_pass' }

        it 'return http response 401' do
          post :sign_up, params: sign_up_params, xhr: true
          expect(response.status).to eq 401
        end
      end
    end
  end
end
