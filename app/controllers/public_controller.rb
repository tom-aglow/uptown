class PublicController < ApplicationController

  before_action :get_barbers_list, only: [:index, :reservation]
  before_action :get_services_list, only: [:index, :reservation]

  def index
    @testimonials = Testimonial.latest.limit(5)
  end

  def reservation
    @shift = Shift.new
    @requisition = Requisition.new
    @client = Client.new

    @times = {
        '11:00:00': '11:00 AM',
        '14:00:00':  '02:00 PM',
        '16:00:00':  '04:00 PM',
        '18:00:00': '06:00 PM'
    }
  end

  def book
    @shift = Shift.where(date: params[:shift][:date],
                         time: params[:shift][:time],
                         barber_id: params[:shift][:barber_id]).first
    @shift.update_attribute(:is_free, false)

    @client = Client.find_or_initialize_by(email: params[:client][:email])
    @client.update_attributes(client_params)

    @requisition = Requisition.new(req_params)
    @requisition.save
  end

  def booking_info

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
