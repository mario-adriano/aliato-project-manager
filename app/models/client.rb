class Client < ApplicationRecord
  acts_as_paranoid

  has_many :projects

  validates :name, presence: true
  validates :phone, presence: true
  validates :document_number, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Endereço de email deve ser válido" }, if: -> { email.present? }
end
