class ProjectFile < ApplicationRecord
  belongs_to :project

  def file=(file)
    self.file_name = file.original_filename
    self.file_data = file.read
  end
end
