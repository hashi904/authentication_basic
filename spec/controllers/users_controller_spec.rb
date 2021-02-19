require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'http status 200' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let!(:user_params) { { nickname: nickname, email: email, password: password } }

    context 'Sign Upに成功する時' do
      let!(:nickname) { 'valid_user' }
      let!(:email) { 'valid_user@gmail.com' }
      let!(:password) { 'valid_pass' }
      let!(:new_user_form) { NewUserForm.new }
      let!(:registration_user) do
        {
          id: 2,
          nickanem: nickname,
          email: email,
          password_digest: 'valid_pass'
        }
      end

      before do
        allow(new_user_form).to receive(:save?).and_return(true)
        allow(new_user_form).to receive(:user).and_return(:registration_user)
      end

      it 'http status 302' do
        post :create, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it 'redirect to sessions_path' do
        post :create, params: { user: user_params }
        expect(response).to redirect_to sessions_path
      end
    end

    context 'Sign Upに失敗する時' do
      context 'nicknameが空の場合' do
        let!(:nickname) { '' }
        let!(:email) { 'valid_user@gmail.com' }
        let!(:password) { 'valid_pass' }

        it 'render sign up' do
          post :create, params: { user: user_params }
          expect(response).to render_template('users/new')
        end
      end

      context 'emailが空の場合' do
        let!(:nickname) { 'valid_user' }
        let!(:email) { '' }
        let!(:password) { 'valid_pass' }

        it 'render sign up' do
          post :create, params: { user: user_params }
          expect(response).to render_template('users/new')
        end
      end

      context 'passwordが空の場合' do
        let!(:nickname) { 'valid_user' }
        let!(:email) { 'valid_user@gmail.com' }
        let!(:password) { '' }

        it 'render sign up' do
          post :create, params: { user: user_params }
          expect(response).to render_template('users/new')
        end
      end
    end
  end
end
