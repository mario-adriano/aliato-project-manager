# == Schema Information
#
# Table name: project_files
#
#  id         :bigint           not null, primary key
#  file_data  :binary
#  file_name  :string
#  price      :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#
# Indexes
#
#  index_project_files_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require "test_helper"

class ProjectFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
