FactoryBot.define do
  factory :user, aliases: [:test_user] do
    nickname { 'test' }
    email { 'test@gmail.com' }
    password { 'testtest' }
  end
end
