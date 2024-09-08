# == Schema Information
#
# Table name: clients
#
#  id              :bigint           not null, primary key
#  address         :string
#  city            :string
#  company_name    :string
#  complement      :string
#  deleted_at      :datetime
#  document_number :string
#  email           :string
#  name            :string
#  neighborhood    :string
#  phone           :string
#  rg              :string
#  state           :string
#  type            :string
#  zip_code        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_clients_on_deleted_at  (deleted_at)
#
class Client < ApplicationRecord
  acts_as_paranoid

  has_many :projects

  validates :name, presence: true
  validates :phone, presence: true
  validates :document_number, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Endereço de email deve ser válido" }, if: -> { email.present? }
end
