class Company < Client
  validates :company_name, presence: true

  def cnpj
    document_number
  end
end
