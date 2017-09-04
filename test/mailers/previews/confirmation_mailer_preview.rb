# Preview all emails at http://localhost:3000/rails/mailers/confirmation_mailer
class ConfirmationMailerPreview < ActionMailer::Preview
  def requisition_confirmation
    ConfirmationMailer.requisition_confirmation(Client.first, Requisition.first).deliver_now
  end
end
