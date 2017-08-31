class PublicController < ApplicationController
  def index
    @services = Service.all()
    @barbers = Barber.all()
    @testimonials = Testimonial.latest.limit(5)
  end

  def reservation
  end
end
