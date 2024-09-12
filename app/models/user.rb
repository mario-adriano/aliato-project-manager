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
class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [ :username ]

  before_validation :set_role

  before_create :set_name_user_admin

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates :name, presence: true, if: -> { self.type == "Operator" }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def admin?
    self.type == "Administrator"
  end

  def operator?
    self.type == "Operator"
  end

  def requires_reset_password?
    is_reset_password && operator?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions.to_h).where([ "lower(username) = :value", { value: username.downcase } ]).first
    else
      where(conditions.to_h).first
    end
  end

  private

  def set_role
    if User.count == 0
      self.type = "Administrator"
    else
      self.type = "Operator"
    end
  end

  def set_name_user_admin
    self.name = self.username if self.type == "Administrator"
  end
end
