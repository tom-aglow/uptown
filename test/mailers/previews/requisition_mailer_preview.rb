# Preview all emails at http://localhost:3000/rails/mailers/confirmation_mailer
class RequisitionMailerPreview < ActionMailer::Preview
  def requisition_confirmation
    RequisitionMailer.requisition_confirmation(Client.first, Requisition.first).deliver_now
  end

  def requisition_reminder
    RequisitionMailer.requisition_reminder(Client.first, Requisition.first).deliver_now
  end
end
