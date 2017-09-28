class Api::ShiftsController < ApplicationController
  def index
    barber = Barber.find(params[:barber])
    shifts = Shift.week_schedule_for_barber(barber.id, Date.parse(params[:date]))

    render json: { data: reformat_week_schedule_array(shifts) }
  end

  def create
    shift = Shift.new(shift_params)
    if shift.save
      render json: { data: shift }
    else
      render json: shift.errors, status: :unprocessable_entity
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:date, :time, :barber_id)
  end

  def reformat_week_schedule_array(shifts)
    data = {}
    shifts.each do |shift|
      data[shift.date] = {} unless data.key?(shift.date)
      data[shift.date][shift.time] = shift unless data[shift.date].key?(shift.time)
    end
    data
  end
end
