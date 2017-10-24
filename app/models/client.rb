class Client < ApplicationRecord
  # Relationships
  has_many :requisitions
  has_many :activities

  # Validation
  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[a-z]{2,}/i
  PHONE_REGEX = /\d{3}.\d{3}.\d{4}/

  validates :full_name, presence: true,
                        length: { maximum: 50 }

  validates :email, presence: true,
                    length: { maximum: 50 },
                    uniqueness: true,
                    format: { with: EMAIL_REGEX },
                    confirmation: true

  validates :phone, presence: true,
                    format: { with: PHONE_REGEX, message: ' should have 11 digits and start with 1' }
end
