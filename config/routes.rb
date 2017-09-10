Rails.application.routes.draw do

  root to: 'public#index'

  get 'index', to: 'public#index'
  get 'reservation', to: 'public#reservation'
  post 'reservation', to: 'public#book', as: 'book'
  get 'booking_info', to: 'public#booking_info'

  get 'admin', to: 'admin#index', as: 'admin_root'
  namespace :admin do
    resources :barbers
  end
end
