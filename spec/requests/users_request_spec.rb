require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'http status 200' do
      get :new
      expect(response.status).to eq 200
    end
  end
end
