class Barber < ApplicationRecord

  # Relationships
  has_many  :shifts
  has_many :requisitions, through: :shifts
  has_many :testimonials, through: :requisitions

  # Scopes
  scope :done_requisitions, -> { requisitions.where(status: 'paid') }

  # Validation
  validates :first_name, presence: true
  validates :last_name, presence: true


  # Additional properties
  def aver_grade
    sprintf('%.1f',testimonials.inject(0){ |sum, el| sum + el.grade }.to_f / testimonials.size) unless testimonials.size == 0
  end

  def amount_of_cuts
    requisitions.where(status: 'paid').count
  end

  def shifts_on_date(date)
    shifts_col = shifts.where(date: date)
    output = {}
    shifts_col.each do |shift|
      output[shift.time.to_sym] = shift.is_free
    end
		output
  end
end
