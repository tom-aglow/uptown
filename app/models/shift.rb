class Shift < ApplicationRecord

  # Relationships
  belongs_to :barber, inverse_of: :shifts
  has_one :requisition, required: false

  # Scopes
  scope :all_available, -> { where(is_free: true).where('date >= ?', Date.current).order(date: :desc, time: :asc) }

  scope :all_available_grouped_by_date_and_time, -> { where('date >= ?', Date.current).where(is_free: true).order(date: :desc, time: :asc).group(:date, :time).maximum(:barber_id) }

  scope :all_available_for_barber, -> (barber_id) { where(barber_id: barber_id).all_available }

  scope :week_schedule_for_barber, -> (barber_id, date) { where(barber_id: barber_id, date: date.beginning_of_week..(date.beginning_of_week + 6)) }

  # Validation
  validates :date, presence: true
  validates :time, presence: true
  validates :barber_id, presence: true

end
