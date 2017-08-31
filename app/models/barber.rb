class Barber < ApplicationRecord
  has_many :shifts

  def aver_grade
    grades = []
    shifts.each do |shift|
      unless shift.requisition.nil?
        grades << shift.requisition.testimonial.grade unless shift.requisition.testimonial.nil?
      end
    end
    grades.inject { |sum, el| sum + el }.to_f / grades.size
  end

  def amount_of_cuts
    cuts = 0
    shifts.each do |shift|
      unless shift.requisition.nil?
        cuts += 1 if shift.requisition.status == 'paid'
      end
    end
    return cuts
  end

  # TODO eager load necessary data for aver_grade and amount_of_cuts methods
end
