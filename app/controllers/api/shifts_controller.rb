class Api::ShiftsController < ApplicationController
  def index
    barber = Barber.find(params[:barber])
		shifts = Shift.week_schedule_for_barber(barber.id, Date.parse(params[:date]))

    render json: { data: shifts }
  end
end
