class Testimonial < ApplicationRecord
  belongs_to :requisition

  scope :latest, -> { order('created_at DESC') }

  def author
    requisition.client.full_name
  end

end
