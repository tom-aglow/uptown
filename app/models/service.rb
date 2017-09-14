class Service < ApplicationRecord
  has_many :requisitions

  validates :name, presence: true
  validates :price, presence: true

end
