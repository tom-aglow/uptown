class Status < ApplicationRecord
  belongs_to :user

  scope :latest, -> { order('created_at DESC').limit(5) }

  validates :user_id, presence: true
  validates :body, presence: true

end
