class Shift < ApplicationRecord
  belongs_to :barber
  has_one :order, required: false
end
