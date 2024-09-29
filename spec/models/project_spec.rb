# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :bigint           not null
#  phase_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_client_id  (client_id)
#  index_projects_on_code       (code) UNIQUE
#  index_projects_on_phase_id   (phase_id)
#  index_projects_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (phase_id => phases.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:phase).counter_cache(true) }
    it { should belong_to(:client) }
    it { should have_many(:project_files).dependent(:destroy) }
  end

  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:code).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:client_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:phase_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index(:client_id) }
    it { should have_db_index(:code).unique(true) }
    it { should have_db_index(:phase_id) }
    it { should have_db_index(:user_id) }
  end

  describe "validations" do
  end

  describe "dependent behavior" do
    it "destroys associated project_files when project is destroyed" do
      project = create(:project)
      project_file = create(:project_file, project: project)

      expect { project.destroy }.to change { ProjectFile.count }.by(-1)
    end
  end
end
