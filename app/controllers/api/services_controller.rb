class Api::ServicesController < ApiController
  def index
    services = Service.all.order(:id)
    render json: { data: services }
  end

  def create
    service = Service.new(service_params)
    if service.save
      render json: { data: service }
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    service = Service.find(params[:id])
    if service.update_attributes(service_params)
      render json: { data: service }, status: 200
    else
      render json: service.errors, status: :unprocessable_entity
     end
  end

  def destroy
    service = Service.find(params[:id])
    service.destroy
  end

  def popular
		services = []
    Service.all.each { |service| services << {name: service.name, popularity: service.popularity} }
    render json: services
  end

  private

  def service_params
    params.require(:service).permit(:name, :price)
  end
end
