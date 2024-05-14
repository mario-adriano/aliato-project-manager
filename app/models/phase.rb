class Phase < ApplicationRecord
  acts_as_paranoid
  acts_as_list top_of_list: 0

  before_validation :first_phase

  before_create :set_position
  before_save -> { self.name.downcase! }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :position, uniqueness: { scope: :deleted_at, message: "a ordem deve ser única" }, if: -> { position.nil? }

  def destroy
    unless self.is_start
      super
    else
      raise AliatoProjectManager::NonRemovableValueError
    end
  end

  def delete
    unless self.is_start
      super
    else
      raise AliatoProjectManager::NonRemovableValueError
    end
  end

  def name_capitalize
    name.capitalize
  end

  private

  def first_phase
    if Phase.count == 0
        self.is_start = true
        self.position = 1
    end
  end

  def set_position
    unless Phase.count == 0
      self.position = Phase.all.order('position ASC').last.position + 1
    end
  end
end
