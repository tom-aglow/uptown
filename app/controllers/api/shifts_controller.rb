class Api::ShiftsController < ApplicationController
  def index
    barber = Barber.find(params[:barber])
    shifts = Shift.week_schedule_for_barber(barber.id, Date.parse(params[:date]))

    render json: { data: reformat_week_schedule_array(shifts) }
  end

  private

  def reformat_week_schedule_array(shifts)
    data = {}
    shifts.each do |shift|
      data[shift.date] = {} unless data.key?(shift.date)
      data[shift.date][shift.time] = shift unless data[shift.date].key?(shift.time)
    end
    data
  end
end
