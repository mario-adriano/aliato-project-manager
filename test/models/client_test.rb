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
require "test_helper"

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = Client.new(
      name: "John Doe",
      phone: "1234567890",
      document_number: "123456789",
      email: "john.doe@example.com"
    )
  end

  test "should be valid with valid attributes" do
    assert @client.valid?
  end

  test "should be invalid without a name" do
    @client.name = nil
    assert_not @client.valid?
    assert_includes @client.errors[:name], "can't be blank"
  end

  test "should be invalid without a phone" do
    @client.phone = nil
    assert_not @client.valid?
    assert_includes @client.errors[:phone], "can't be blank"
  end

  test "should be invalid without a document number" do
    @client.document_number = nil
    assert_not @client.valid?
    assert_includes @client.errors[:document_number], "can't be blank"
  end

  test "should be valid with a valid email" do
    @client.email = "valid.email@example.com"
    assert @client.valid?
  end

  test "should be invalid with an invalid email" do
    @client.email = "invalid_email"
    assert_not @client.valid?
    assert_includes @client.errors[:email], "Endereço de email deve ser válido"
  end

  test "should be valid without an email" do
    @client.email = nil
    assert @client.valid?
  end
end
