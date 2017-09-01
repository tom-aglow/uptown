class Requisition < ApplicationRecord

  # Relationships
  belongs_to :shift
  belongs_to :client
  belongs_to :service
  has_one :testimonial

end
