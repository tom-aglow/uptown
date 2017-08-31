class PublicController < ApplicationController
  def index
    @services = Service.all()
    @barbers = Barber.all()
    @testimonials = Testimonial.latest.limit(5)
  end

  def reservation
    @shift = Shift.new
  end

  def book
    @shift = Shift.where(date: params[:shift][:date],
                         time: params[:shift][:time],
                         barber_id: params[:shift][:barber_id]).first
    @shift.update_attribute(:is_free, true)
  end

end
