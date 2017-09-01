class Client < ApplicationRecord

  # Relationships
  has_many :requisitions

  # Validation
  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[a-z]{2,}/i
  PHONE_REGEX = /1\d{10}/

  validates :full_name, presence: true,
            length: {maximum: 50}

  validates :email, presence: true,
            length: { maximum: 50 },
            uniqueness: true,
            format: { with: EMAIL_REGEX },
            confirmation: true

  validates :phone, presence: true,
            length: { is: 11 },
            format: { with: PHONE_REGEX, message: ' should have 11 digits and start with 1' }

end
