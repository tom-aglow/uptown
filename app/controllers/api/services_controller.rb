class Api::ServicesController < ApiController
  def index
    services = Service.all.order(:id)
    render json: { data: services }
  end

  def create
    service = Service.new(service_params)
    service.save
    render json: { data: service }
  end

  def update
    service = Service.find(params[:id])
    service.update_attributes(service_params)
  end

  def destroy
    service = Service.find(params[:id])
    service.destroy
  end

  private
  def service_params
    params.require(:service).permit(:name, :price)
  end
end
