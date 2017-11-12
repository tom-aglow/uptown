class Service < ApplicationRecord
  has_many :requisitions

  validates :name, presence: true
  validates :price, presence: true

  # Additional properties
  def popularity
    requisitions.where(status: %w[paid booked]).count
  end
end
