class VueController < ApplicationController
  layout 'vue-playground'

  def index

  end

  def skills
    render json: %w[laravel ruby PHP]
  end
end
