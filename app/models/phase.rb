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
class Phase < ApplicationRecord
  acts_as_paranoid
  acts_as_list top_of_list: 0

  has_many :projects, dependent: :restrict_with_error

  before_validation :first_phase

  after_initialize :set_default_values

  before_create :set_position
  before_save :adjust_text_color
  before_save -> { self.name.downcase! if name.present? }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  # validates :position, uniqueness: { scope: :deleted_at, message: "a ordem deve ser única" }, if: -> { position.nil? }

  # enum color: { blue: "#3b82f6", red: "#ef4444", green: "#10b981", yellow: "#f59e0b" }

  def destroy
    unless self.position == 1
      super
    else
      raise Exceptions::NonRemovableValueError
    end
  end

  def delete
    unless self.position == 1
      super
    else
      raise Exceptions::NonRemovableValueError
    end
  end

  def name_capitalize
    name.capitalize
  end

  # Returns the previous phase based on the current phase's position.
  #
  # This method queries the database for a phase with a position less than the current phase's position,
  # and where the is_end attribute is either false or nil. It then orders the results in descending order
  # based on the position and returns the first phase.
  #
  # Returns:
  # - The previous phase if found, or nil if no previous phase exists.
  def prev_phase
    Phase.where("position < ?", position).where(is_end: [ false, nil ]).order("position DESC").first
  end

  def next_phase
    Phase.where("position > ?", position).where(is_end: [ false, nil ]).first
  end

  private

  def first_phase
    if Phase.count == 0
        self.position = 1
    end
  end

  def set_position
    unless Phase.count == 0
      self.position = Phase.all.order("position ASC").last.position + 1
    end
  end

  def adjust_text_color
    self.text_color = light_background? ? "black" : "white"
  end

  def light_background?
    r, g, b = color.delete("#").scan(/../).map(&:hex)
    brightness = (r * 299 + g * 587 + b * 114) / 1000
    brightness > 150
  end

  def set_default_values
    self.color ||= "#ffffff"
    self.text_color ||= "black"
  end
end
