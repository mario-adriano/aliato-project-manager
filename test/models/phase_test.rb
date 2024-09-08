# == Schema Information
#
# Table name: phases
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text
#  is_end      :boolean
#  name        :string
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_phases_on_deleted_at  (deleted_at)
#  index_phases_on_position    (position)
#
require "test_helper"

class PhaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
