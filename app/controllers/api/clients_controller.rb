class Api::ClientsController < ApplicationController
  def activities
    result = []
    activities = Activity.order('created_at DESC').limit(5)
    activities.each { |activity| result << method('action_' + activity.action).call(activity) }
    render json: result
  end

  private

  def action_booking(activity)
    {
      name: activity.client.full_name,
      action: 'booking',
      service: activity.eventable.service.name,
      booked_at: activity.eventable.shift.date,
      date: activity.created_at
    }
  end

  def action_testimonial(activity)
    {
      name: activity.client.full_name,
      action: 'testimonial',
      date: activity.created_at
    }
  end
end
