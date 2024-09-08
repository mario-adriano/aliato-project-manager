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
class ProjectFile < ApplicationRecord
  belongs_to :project

  # Sets the file attributes of the ProjectFile model.
  #
  # @param [ActionDispatch::Http::UploadedFile] file The uploaded file object.
  # @return [void]
  def file=(file)
    self.file_name = file.original_filename
    self.file_data = file.read
  end
end
