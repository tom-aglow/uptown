class Requisition < ApplicationRecord

  # Relationships
  belongs_to :shift
  has_one :barber, through: :shift
  belongs_to :client
  belongs_to :service
  has_one :testimonial

  # Scopes
  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  # Sending emails methods
  def send_confirmation
    RequisitionMailer.requisition_confirmation(client, self).deliver_later
  end

  def shedule_reminder
    Time.zone = 'America/Vancouver'
    shift = self.shift

    # Reminder should be sent one day before appointment
    time_to_send = Time.parse(shift.date.to_s + ' ' + shift.time) - Time.now - (24 * 60 * 60)

    # Send a reminder only if there is more than 6 hours left before client visit
    EmailReminderJob.perform_in(time_to_send, client, self) if time_to_send > 6 * 60 * 60
  end
end
