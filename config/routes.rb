Rails.application.routes.draw do
  

  get 'body_weights/index'

  get 'body_weights/create'

  get '/auth/:provider/callback',    to: 'sessions#sns_create',      as: :auth_callback
  get 'auth/failure',                to: redirect('/'),                 as: :auth_failure
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    collection { post :import }
    member do
      get 'edit_basic_info'
      
      get 'workouts/bodypart_select'
      
      get 'workouts/traning_lists'
      get 'workouts/traning_day_contents'
      get 'workouts/index_menu_modal'
      
      
    end
    resources :days, :only => [:index] do
      resources :workouts do
      end
    end
    resources :traning_menus do
    end
    resources :body_weights do
    end
  end
  
  
  
end