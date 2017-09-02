class Shift < ApplicationRecord

  # Relationships
  belongs_to :barber
  has_one :requisition, required: false

  # Scopes
  scope :all_available, -> { where('shifts.is_free', true).where('shifts.date >= ?', Date.current).order(date: :desc, time: :asc) }
  scope :group_shifts_by_date_and_time, -> do
    # leave only one shift for date&time with maximum barber_id
    joins("INNER JOIN (
              SELECT shifts.date, shifts.time, max(shifts.barber_id) as 'barber_id'
              FROM shifts
              GROUP BY shifts.date, shifts.time
            ) b
            ON shifts.date = b.date AND shifts.time = b.time AND shifts.barber_id = b.barber_id")
  end
  scope :all_available_for_barber, -> (barber_id) { where(is_free: true, barber_id: barber_id).where('date >= ?', Date.current).order(date: :desc) }

  # Validation
  validates :date, presence: true
  validates :time, presence: true
  validates :barber_id, presence: true

end
