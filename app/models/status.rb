class Status < ApplicationRecord
  belongs_to :user

  scope :latest, -> {order('created_at DESC')}
end
