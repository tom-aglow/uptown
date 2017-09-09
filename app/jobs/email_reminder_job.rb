class EmailReminderJob
  include SuckerPunch::Job

  def perform(client, req)
    RequisitionMailer.requisition_reminder(client, req).deliver_later
  end
end
