Rails.application.routes.draw do

  root to: 'public#index'

  get 'index', to: 'public#index'
  get 'reservation', to: 'public#reservation'
  post 'reservation', to: 'public#book', as: 'book'

end
