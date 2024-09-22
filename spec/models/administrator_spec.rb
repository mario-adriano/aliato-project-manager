require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "associations" do
  end

  describe "validations" do
  end

  describe "database columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: "") }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: "", null: false) }
    it { is_expected.to have_db_column(:is_reset_password).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:type).of_type(:string) }
    it { is_expected.to have_db_column(:username).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe "indexes" do
    it { is_expected.to have_db_index(:deleted_at) }
    it { is_expected.to have_db_index(:reset_password_token).unique(true) }
    it { is_expected.to have_db_index(:username).unique(true) }
  end
end
