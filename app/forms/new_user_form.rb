class NewUserForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :nickname, :email, :password
  attr_reader :user

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def to_model
    User.new(nickname: nickname, email: email, password: password)
  end

  def save?
    return false if invalid?

    @user = User.new(nickname: nickname, email: email, password: password)
    @user.save
  end
end
