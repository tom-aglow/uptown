class Admin::BarbersController < AdminController
  def today
    render json: { data: Barber.all }
  end
end
