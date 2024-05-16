class Company < Client
  validate :valid_cnpj

  def cnpj
    document_number
  end

  private

  def valid_cnpj
    unless CNPJ.valid?(document_number, strict: true)
      self.errors.add(:document_number, "não é válido")
    end
  end
end
