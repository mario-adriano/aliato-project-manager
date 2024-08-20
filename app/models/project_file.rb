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
