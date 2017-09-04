class ConfirmationMailer < ApplicationMailer
  default from: 'info@uptownbarbers.ca'

  def requisition_confirmation(client, req)
    @client = client
    @req = req

    mail(
        to: @client.email,
        subject: 'Uptown Barbers | Confirmation of your booking'
    )
  end
end
