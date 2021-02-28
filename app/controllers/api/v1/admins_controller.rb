class Api::V1::AdminsController < Api::ApiApplicationController
  before_action :jwt_authenticate
  def index
    @users = User.all
    render json: { status: 'request ok' }
  end
end
