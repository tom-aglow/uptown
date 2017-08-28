Rails.application.routes.draw do

  root to: 'public#index'

  get 'public/index'
  get 'public/reservation'

end
