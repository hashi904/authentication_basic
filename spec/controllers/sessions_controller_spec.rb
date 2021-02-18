require 'rails_helper'

describe SessionsController, type: :controller do
  let(:user) { create(:user) }

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

      it 'http status 200' do
        post :create, params: { new_session_form: new_session_params }
        expect(response.status).to eq 200
      end
    end
  end
end
