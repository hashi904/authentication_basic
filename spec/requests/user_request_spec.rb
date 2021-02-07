require 'rails_helper'

RSpec.describe "Users", type: :request do
  context 'ユーザーが作成される？' do
    let!(:user) { create(:user) }
    it do
    end
  end
end
