class Requisition < ApplicationRecord

  # Relationships
  belongs_to :shift
  has_one :barber, through: :shift
  belongs_to :client
  belongs_to :service
  has_one :testimonial

  def send_confirmation
    ConfirmationMailer.requisition_confirmation(client, self).deliver_later
  end
end
