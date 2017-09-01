class PublicController < ApplicationController

  before_action :get_barbers_list, only: [:index, :reservation, :book]
  before_action :get_services_list, only: [:index, :reservation, :book]

  def index
    @testimonials = Testimonial.latest.limit(5)
  end

  def reservation
    @shift = Shift.new
    @requisition = Requisition.new
    @client = Client.new
  end

  def book
    # @shift = Shift.where(date: params[:shift][:date],
    #                      time: params[:shift][:time],
    #                      barber_id: params[:shift][:barber_id]).first
    # @shift.update_attribute(:is_free, false)

    @client = Client.find_or_initialize_by(email: params[:client][:email])
    @client.update_attributes(client_params)

    @shift = Shift.new
    @requisition = Requisition.new
    render('reservation')
    # @requisition = Requisition.new(req_params)
    # @requisition.save
  end

  def booking_info
    @shifts_available = Shift.available_all(params[:barber_id])

    if request.xhr?
      render :json => {
          :shifts => @shifts_available
      }
    end
  end

  private

  def client_params
    params.require(:client).permit(:full_name, :email, :phone)
  end

  def req_params
    {
        client_id: @client.id,
        service_id: params[:requisition][:service_id],
        shift_id: @shift.id,
        status: 'booked'
    }
  end

  def get_barbers_list
    @barbers = Barber.all()
  end

  def get_services_list
    @services = Service.all()
  end
end
