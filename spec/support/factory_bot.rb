RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end