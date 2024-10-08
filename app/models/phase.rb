class Phase < ApplicationRecord
  acts_as_paranoid
  acts_as_list top_of_list: 0

  before_validation :first_phase

  before_create :set_position
  before_save -> { self.name.downcase! }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :position, uniqueness: { scope: :deleted_at, message: "a ordem deve ser única" }, if: -> { position.nil? }

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
    Phase.where("position < ?", position).where(is_end: [false, nil]).order('position DESC').first
  end

  def next_phase
    Phase.where("position > ?", position).where(is_end: [false, nil]).first
  end

  private

  def first_phase
    if Phase.count == 0
        self.position = 1
    end
  end

  def set_position
    unless Phase.count == 0
      self.position = Phase.all.order('position ASC').last.position + 1
    end
  end
end
