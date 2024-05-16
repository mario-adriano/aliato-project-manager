class Project < ApplicationRecord
  belongs_to :user
  belongs_to :phase
  belongs_to :client
end
