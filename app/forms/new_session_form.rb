class NewSessionForm
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true

  def save
    return false if invalid?

    true
  end
end
