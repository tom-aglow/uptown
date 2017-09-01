class Shift < ApplicationRecord

  # Relationships
  belongs_to :barber
  has_one :requisition, required: false

  # Scopes
  scope :available_all, -> (barber_id) { where(is_free: true, barber_id: barber_id).where('date >= ?', Date.current).order(date: :desc) }

  # Validation
  validates :date, presence: true
  validates :time, presence: true
  validates :barber_id, presence: true

end
