require 'rails_helper'

describe SessionsController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET #new' do
    it 'http status 200' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'GET #create' do
    let!(:new_session_params) { { email: email, password: password } }

    context 'ログインに成功する時' do
      let!(:email) { 'test@gmail.com' }
      let!(:password) { 'testtest' }

      it 'http status 302' do
        post :create, params: { new_session_form: new_session_params }
        expect(response.status).to eq 302
      end

      it 'redirect to root path' do
        post :create, params: { new_session_form: new_session_params }
        expect(response).to redirect_to sessions_path
      end
    end

    context '不正な値を入力した時' do
      context 'メールアドレスが間違っている時' do
        let!(:email) { 'invalid@gmail.com' }
        let!(:password) { 'testtest' }

        it 'render sign in' do
          post :create, params: { new_session_form: new_session_params }
          expect(response).to render_template('sessions/new')
        end
      end

      context 'パスワードが間違っている時' do
        let!(:email) { 'test@gmail.com' }
        let!(:password) { 'invalid_password' }

        it 'render to sign in' do
          post :create, params: { new_session_form: new_session_params }
          expect(response).to render_template('sessions/new')
        end
      end
    end
  end
end
