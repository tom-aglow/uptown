class Shift < ApplicationRecord
  belongs_to :barber
  has_one :requisition, required: false
end
