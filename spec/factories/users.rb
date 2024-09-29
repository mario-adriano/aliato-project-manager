FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    encrypted_password { Devise::Encryptor.digest(User, 'password') }
    is_reset_password { false }
    name { "John Doe" }
    remember_created_at { nil }
    reset_password_sent_at { nil }
    reset_password_token { nil }
    type { "User" }

    before(:create) { |user| user.valid? }

    trait :operator do
      type { "Operator" }
      name { "Operator Name" }
    end
  end
end
