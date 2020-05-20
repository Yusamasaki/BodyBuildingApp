Rails.application.routes.draw do
  get 'bases', to: 'bases#show'
  get '/new', to: 'bases#new'
  patch '/new', to: 'bases#create'
  delete '/destroy', to: 'bases#destroy'
  get '/edit', to: 'bases#edit'
  patch '/update/:id/', to: 'bases#update'

  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  patch '/index_update', to: 'users#index'
  
  resources :users do
    collection { post :import }
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'edit_base_info'
      patch 'update_base_info'
      get 'index_attendance'
      post 'approval_application'
      get 'notice_approval_application'
      patch 'update_notice_approval_application'
      
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'attendances/notice_edit_one_month'
      patch 'attendances/update_notice_one_month'
      get 'attendances/edit_one_month_log'
      
      get 'attendances/edit_overwork_request'
      patch 'attendances/update_overwork_request'
      get 'attendances/notice_overwork_request'
      patch 'attendances/update_notice_overwork_request'
      get 'attendances/notice_overwork_request_B'
      get 'attendances/notice_overwork_request_C'
    end
    resources :attendances do
    end
  end
  
  resources :bases do
    member do
      get 'edit_base'
      patch 'update_base'
    end
  end
end