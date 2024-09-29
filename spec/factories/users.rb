# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  deleted_at             :datetime
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  is_reset_password      :boolean          default(FALSE)
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
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
