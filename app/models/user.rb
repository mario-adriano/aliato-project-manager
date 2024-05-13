class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:username]

  before_validation :set_role

  before_create :set_name_user_admin

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates :name, presence: true, if: -> { self.type == 'Operator' }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions.to_h).where(["lower(username) = :value", { value: username.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  private

  def set_role
    if User.count == 0
      self.type = 'Admin'
    else
      self.type = 'Operator'
    end
  end

  def set_name_user_admin
    self.name = self.username if self.type == 'Admin'
  end
end
