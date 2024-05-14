class Phase < ApplicationRecord
  acts_as_paranoid

  before_create :first_phase
  before_save -> { self.name.downcase! }

  validates :name, presence: true, uniqueness: { case_sensitive: false }

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

  def set_as_starting_phase
    Phase.transaction do
      Phase.update_all(is_start: false)

      self.is_start = true
      self.is_end = false
      save

      raise ActiveRecord::Rollback unless Phase.where(is_start: true).one?
    end
  end

  private

  def first_phase
    self.is_start = true if Phase.count == 0
  end
end
