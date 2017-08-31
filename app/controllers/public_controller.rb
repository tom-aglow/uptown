class PublicController < ApplicationController
  def index
    @services = Service.all()
    @barbers = Barber.all()
  end

  def reservation
  end
end
