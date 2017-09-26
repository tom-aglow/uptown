class Api::ShiftsController < ApplicationController
  def index
    barbers = Barber.all.order(:id)
    render json: { data: { barbers: barbers } }
  end
end
