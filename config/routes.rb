Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    collection { post :import }
    member do
      get 'bases_info'
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'edit_base_info'
      patch 'update_base_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'index_attendance'
    end
    resources :attendances do
      patch 'update'
      
      get 'edit_overwork_request'
      patch 'update_overwork_request'
    end
  end
  
end