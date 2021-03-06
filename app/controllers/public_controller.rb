class PublicController < ApplicationController

  before_action :get_barbers_list, only: [:index, :reservation, :book]
  before_action :get_services_list, only: [:index, :reservation, :book]

  def index
    @testimonials = Testimonial.includes(requisition: [:client]).latest.limit(5)
  end

  def reservation
    @shift = Shift.new
    @requisition = Requisition.new
    @client = Client.new
    flash[:errors] = []
  end

  def book
    @shift = Shift.where(date: params[:shift][:date],
                         time: params[:shift][:time],
                         barber_id: params[:shift][:barber_id]).first

    @client = Client.find_or_initialize_by(email: params[:client][:email])
    is_client_saved = @client.update_attributes(client_params)

    @requisition = Requisition.new(req_params)

    # validation of shifts fields
    flash[:errors] = []

    if @shift.nil?
      flash[:errors] << 'Please select correct date' if params[:shift][:date].blank?
      flash[:errors] << 'Please select correct time' if params[:shift][:time].blank?
      flash[:errors] << 'Please select a barber' if params[:shift][:barber_id].blank?
      @shift = Shift.new(shift_params)
    end

    # validation of requisition field
    if params[:requisition].nil? || params[:requisition][:service_id].blank?
      (flash[:errors] ||= []) << 'Please select a service'
    end

    if is_client_saved && flash[:errors].blank? && @requisition.save
      @shift.update_attribute(:is_free, false)
      @requisition.send_confirmation
      @requisition.shedule_reminder
      flash[:notice] = 'We\'ve reserved a seat for you and sent you the email with details of your booking. See you soon.'
      redirect_to(root_path)
    else
      render('reservation')
    end
  end

  def booking_info
    if params[:barber_id].blank?
      @shifts_available = reformat_shifts_array(Shift.all_available_grouped_by_date_and_time)
    else
      @shifts_available = Shift.all_available_for_barber(params[:barber_id])
    end

    render json: { shifts: @shifts_available } if request.xhr?
  end

  private

  def shift_params
    params.require(:shift).permit(:date, :time, :barber_id)
  end

  def client_params
    params.require(:client).permit(:full_name, :email, :phone)
  end

  def req_params
    Hash.new.tap do |req_params|
      req_params[:client_id] = @client.id
      req_params[:service_id] = params[:requisition][:service_id] unless params[:requisition].nil?
      req_params[:shift_id] = @shift.id unless @shift.nil?
      req_params[:status] = 'booked'
    end
  end

  def get_barbers_list
    @barbers = Barber.all
  end

  def get_services_list
    @services = Service.all
  end

  def reformat_shifts_array(shifts)
    col = []
    shifts.each do |shift|
      col << { date: shift[0][0], time: shift[0][1], barber_id: shift[1] }
    end
    return col
  end
end
