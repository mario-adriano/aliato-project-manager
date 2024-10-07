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
class Individual < Client
  alias_attribute :cpf, :document_number

  alias_method :cpf_formatted, :document_number_formatted

  validate :valid_cpf

  private

  def valid_cpf
    unless CPF.valid?(document_number, strict: true)
      self.errors.add(:document_number, "não é válido")
    end
  end
end
