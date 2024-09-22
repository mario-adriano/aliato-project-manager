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
