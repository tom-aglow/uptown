class Shift < ApplicationRecord
  belongs_to :barber
  has_one :requisition, required: false

  scope :available_all, -> (barber_id) { where(is_free: true, barber_id: barber_id).where('date >= ?', Date.current).order(date: :desc) }
end
