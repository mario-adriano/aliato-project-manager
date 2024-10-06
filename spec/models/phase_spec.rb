# == Schema Information
#
# Table name: phases
#
#  id             :bigint           not null, primary key
#  color          :string
#  deleted_at     :datetime
#  description    :text
#  is_end         :boolean
#  name           :string
#  position       :integer
#  projects_count :integer          default(0), not null
#  text_color     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_phases_on_deleted_at  (deleted_at)
#  index_phases_on_position    (position)
#
require 'rails_helper'

RSpec.describe Phase, type: :model do
  describe "associations" do
    it { should have_many(:projects) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "database columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:color).of_type(:string) }
    it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:is_end).of_type(:boolean) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:position).of_type(:integer) }
    it { is_expected.to have_db_column(:text_color).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe "indexes" do
    it { is_expected.to have_db_index(:deleted_at) }
    it { is_expected.to have_db_index(:position) }
  end

  describe "callbacks" do
    it "sets default color to #ffffff on initialization" do
      phase = Phase.new
      expect(phase.color).to eq("#ffffff")
    end

    it "sets default text_color to black on initialization" do
      phase = Phase.new
      expect(phase.text_color).to eq("black")
    end

    it "downcases name before save" do
      phase = Phase.new(name: "My Phase")
      phase.save
      expect(phase.name).to eq("my phase")
    end

    it "sets text_color to black for light background before save" do
      phase = Phase.new(name: "My Phase", color: "#51ec53")
      phase.save
      expect(phase.text_color).to eq("black")
    end

    it "sets text_color to white for dark background before save" do
      phase = Phase.new(name: "My Phase", color: "#416be6")
      phase.save
      expect(phase.text_color).to eq("white")
    end

    it "sets position before creation when not first phase" do
      create(:phase, position: 1)
      phase = build(:phase)
      phase.save
      expect(phase.position).to eq(2)
    end

    it "raises NonRemovableValueError if the phase is the first" do
      phase = create(:phase, position: 1)
      expect { phase.destroy }.to raise_error(Exceptions::NonRemovableValueError)
    end
  end
end
