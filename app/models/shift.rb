class Shift < ApplicationRecord

  # Relationships
  belongs_to :barber
  has_one :requisition, required: false

  # Scopes
  scope :all_available, -> { where(is_free: true).where('date >= ?', Date.current).order(date: :desc, time: :asc) }
  scope :group_shifts_by_date_and_time, -> do
    # leave only one shift for date&time with maximum barber_id
    joins("INNER JOIN (
              SELECT shifts.date, shifts.time, max(shifts.barber_id) as 'barber_id'
              FROM shifts
              WHERE shifts.date >= CURDATE() and shifts.is_free = true
              GROUP BY shifts.date, shifts.time
            ) b
            ON shifts.date = b.date AND shifts.time = b.time AND shifts.barber_id = b.barber_id
            WHERE shifts.date >= CURDATE() AND shifts.is_free = true
            ORDER BY shifts.date DESC, shifts.time ASC
  ")
  end
  # scope :group_shifts_by_date_and_time, -> { where('date >= ?', Date.current).where(is_free: true).order(date: :desc, time: :asc).group(:date, :time).maximum(:barber_id) }
  # TODO change scope for grouping all available shifts

  scope :all_available_for_barber, -> (barber_id) { where(barber_id: barber_id).all_available }

  # Validation
  validates :date, presence: true
  validates :time, presence: true
  validates :barber_id, presence: true

end
