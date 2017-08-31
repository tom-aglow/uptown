class PublicController < ApplicationController
  def index
    @services = Service.all()

  end

  def reservation
  end
end
