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

RSpec.describe Client, type: :model do
  describe "associations" do
    it { should have_many(:projects) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:document_number) }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe "normalizes" do
    context "document_number" do
      it "removes non-numeric characters from document_number" do
        client = Client.new(document_number: "47.307.322/0001-41")
        client.valid?
        expect(client.document_number).to eq("47307322000141")
      end
    end
  end

  describe "#document_number_formatted" do
    context "when the client is a Company" do
      it "formats the document_number as CNPJ" do
        client = Client.new(type: "Company", document_number: "47307322000141")
        expect(client.document_number_formatted).to eq("47.307.322/0001-41")
      end
    end

    context "when the client is an individual" do
      it "formats the document_number as CPF" do
        client = Client.new(type: "Individual", document_number: "14705948971")
        expect(client.document_number_formatted).to eq("147.059.489-71")
      end
    end
  end

  describe "database columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
    it { is_expected.to have_db_column(:document_number).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end

  describe "indexes" do
    it { is_expected.to have_db_index(:deleted_at) }
  end
end
