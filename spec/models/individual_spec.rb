require 'rails_helper'

RSpec.describe Individual, type: :model do
  describe "associations" do
  end

  describe "validations" do
    it { should validate_presence_of(:document_number) }

    it "validates the CPF" do
      individual = Individual.new(document_number: "invalid_cpf")
      individual.valid?
      expect(individual.errors[:document_number]).to include("não é válido")
    end

    it "is valid with a valid CPF" do
      valid_cpf = "134.348.866-48"
      individual = Individual.new(document_number: valid_cpf)
      expect(individual.errors[:document_number]).to be_empty
    end
  end

  describe "database columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:company_name).of_type(:string) }
    it { is_expected.to have_db_column(:complement).of_type(:string) }
    it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:document_number).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:neighborhood).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
    it { is_expected.to have_db_column(:rg).of_type(:string) }
    it { is_expected.to have_db_column(:state).of_type(:string) }
    it { is_expected.to have_db_column(:type).of_type(:string) }
    it { is_expected.to have_db_column(:zip_code).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe "indexes" do
    it { is_expected.to have_db_index(:deleted_at) }
  end
end
