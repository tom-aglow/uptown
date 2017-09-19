class Admin::ApiController < ApplicationController
  def today
    data = []
    @barbers = Barber.all.includes(:shifts)
    @barbers.each do |barber|
      data << barber.attributes.merge(shifts: barber.shifts_on_date(Date.today))
    end
    render json: { data: data }
  end

  def services
    data = Service.all.order(:id)
    render json: { data: data }
  end

  def services_update
    service = Service.find(params[:id])
    service.update_attributes(service_params)
  end


  private
  def service_params
    params.require(:service).permit(:name, :price)
  end
end
