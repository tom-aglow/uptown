Rails.application.routes.draw do

  root to: 'public#index'

  get 'index', to: 'public#index'
  get 'reservation', to: 'public#reservation'
  post 'reservation', to: 'public#book', as: 'book'
  get 'booking_info', to: 'public#booking_info'

  # Admin routes
  get 'admin', to: 'admin#index', as: 'admin_root'
  namespace :admin do
    get 'access/login', as: 'login'
    post 'access/attempt_login', as: 'attempt_login'
    get 'access/logout', as: 'logout'

    resources :barbers
  end

  # API routes
  namespace :api do
    get 'w-today', to: '/admin/api#today'
    get 'v-services', to: '/admin/api#services'
    patch 'v-services/:id', to: '/admin/api#services_update'
  end
end
