Rails.application.routes.draw do
  

  get '/auth/:provider/callback',    to: 'sessions#google_create',      as: :auth_callback
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
      patch 'update_basic_info'
      
      get 'meals_input'    
      
      get 'workouts/workout'
      
      get 'workouts/bodypart_menu'
      get 'workouts/bodypart_menu_index'
      get 'workouts/traning_menu'
      get 'workouts/traning_contents'
      get 'workouts/traning_day_contents'
      
      get 'workouts/index_bodypart'
      get 'workouts/index_menu_modal'
      
      get 'traning_menus/new_workouts'
      post 'traning_menus/new_workouts_create'
      
    end
    resources :days do
      resources :workouts do
      end
    end
    resources :traning_menus do
    end
    
    resources :meals do
    end
    resources :bodyweights do
    end
    resources :posts do
    end
  end
  
  
  
end