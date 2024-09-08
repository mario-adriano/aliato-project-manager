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
  # test "the truth" do
  #   assert true
  # end
end
