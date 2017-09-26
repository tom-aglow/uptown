class Api::BarbersController < ApplicationController
	def index
		barbers = Barber.all.order(:id)
		render json: barbers
	end
end
