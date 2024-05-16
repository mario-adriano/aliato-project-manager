class Individual < Client
  validate :valid_cpf

  def cpf
    document_number
  end

  private

  def valid_cpf
    unless CPF.valid?(document_number, strict: true)
      self.errors.add(:document_number, "não é válido")
    end
  end
end
