class NewUserForm
  include ActiveModel::Model

  attr_accessor :nickname, :email, :password

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def to_model
    User.new(nickname: nickname, email: email, password: password)
  end

  def save
    return false if invalid?
    to_model.save
  end
end
