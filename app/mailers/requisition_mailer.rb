class RequisitionMailer < ApplicationMailer
  default from: 'info@uptownbarbers.ca'

  def requisition_confirmation(client, req)
    @client = client
    @req = req
    send_email('Confirmation of your booking', 'requisition_confirmation')
  end

  def requisition_reminder(client, req)
    @client = client
    @req = req
    send_email('Reminder of your booking', 'requisition_reminder')
  end


  private

  def send_email(subject, template)
    mail(
        to: @client.email,
        subject: "Uptown Barbers | #{subject}",
        template_path: 'mailers',
        template_name: template
    )
  end
end
