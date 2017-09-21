class ApiController < ApplicationController
  def today
    data = []
    @barbers = Barber.all.includes(:shifts)
    @barbers.each do |barber|
      data << barber.attributes.merge(shifts: barber.shifts_on_date(params[:date]))
    end
    render json: { data: data }
  end
end
