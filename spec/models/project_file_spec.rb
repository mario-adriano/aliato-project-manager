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
require 'rails_helper'

RSpec.describe ProjectFile, type: :model do
  describe "associations" do
    it { should belong_to(:project) }
  end

  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:file_data).of_type(:binary) }
    it { should have_db_column(:file_name).of_type(:string) }
    it { should have_db_column(:price).of_type(:decimal).with_options(precision: 8, scale: 2) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:project_id).of_type(:integer).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index(:project_id) }
  end

  describe "methods" do
    describe "#file=" do
      let(:file) { double("file", original_filename: "test_file.txt", read: "file content") }
      let(:project_file) { ProjectFile.new }

      it "sets the file_name and file_data" do
        project_file.file = file

        expect(project_file.file_name).to eq("test_file.txt")
        expect(project_file.file_data).to eq("file content")
      end
    end
  end
end
