class Project < ApplicationRecord
  belongs_to :user
  belongs_to :phase
  belongs_to :client

  has_many :project_files, dependent: :destroy
end
