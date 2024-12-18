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
require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "associations" do
  end

  describe "validations" do
    it { should validate_presence_of(:document_number) }
    it "validates the CNPJ" do
      company = Company.new(document_number: "invalid_cnpj")
      company.valid?
      expect(company.errors[:document_number]).to include("não é válido")
    end

    it "is valid with a valid CNPJ" do
      valid_cnpj = "90.958.836/0001-96"
      company = Company.new(document_number: valid_cnpj)
      expect(company.errors[:document_number]).to be_empty
    end
  end

  describe "alias_method and alias_attribute" do
    it "returns the cnpj using alias_attribute" do
      company = Company.new(document_number: "90.958.836/0001-96")
      expect(company.cnpj).to eq("90958836000196")
    end

    it "returns the formatted CNPJ using alias_method" do
      company = Company.new(document_number: "90958836000196")
      expect(company.cnpj_formatted).to eq("90.958.836/0001-96")
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
