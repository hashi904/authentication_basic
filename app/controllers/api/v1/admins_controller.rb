class Api::V1::AdminsController < Api::ApiApplicationController
  before_action :jwt_authenticate, only: [:index]

  def index
    @users = User.all
    render json: { status: 'request ok', users: @users }
  end

  def call
    # send mail
    NotificationMailer.send_confirm_to_user.deliver
    render json: { status: 'send mail' }
  end
end
