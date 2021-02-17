require 'rails_helper'

describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'http status 200' do
      get :new
      expect(response.status).to eq 200
    end
  end
end
