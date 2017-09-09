class ReminderMailer < ApplicationMailer
  default from: 'info@uptownbarbers.ca'

  def requisition_reminder(client, req)
    @client = client
    @req = req

    mail(
        to: @client.email,
        subject: 'Uptown Barbers | Reminder of your booking'
    )
  end
end
