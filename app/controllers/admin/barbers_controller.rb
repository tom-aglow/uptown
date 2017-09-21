class Admin::BarbersController < AdminController
  def today
    data = []
    @barbers = Barber.all.includes(:shifts)
    @barbers.each do |barber|
      data << barber.attributes.merge(shifts: barber.shifts_on_date(Date.today))
    end
    render json: { data: data }
  end
end
