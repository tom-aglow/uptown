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
  end

  # API routes
  namespace :api do
    get 'w-today/:date', to: '/api#today'

    get 'services/popular', to: '/api/services#popular'
    resources :services

    resources :barbers

    resources :shifts
    get 'shifts/:barber/:date', to: '/api/shifts#index'

    get 'clients/activities', to: '/api/clients#activities'
  end
end
