class Api::RequisitionsController < ApplicationController
	def trend
		req = Requisition.created_between(1.week.ago, Time.now).group("created_at::date").count
		render json: req
	end
end
