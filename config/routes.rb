Rails.application.routes.draw do

  root to: 'public#index'

  get 'vue-playground', to: 'vue#index'
  get 'vue-playground/skills', to: 'vue#skills'
  get 'vue-playground/projects/new', to: 'vue#projects_new'
  post 'vue-playground/projects', to: 'vue#projects_create', as: 'projects'
  get 'vue-playground/stream', to: 'vue#stream_index', as: 'stream'
  get 'vue-playground/stream/statuses', to: 'vue#stream_statuses'
  post 'vue-playground/stream/statuses', to: 'vue#stream_statuses_create'

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
end
