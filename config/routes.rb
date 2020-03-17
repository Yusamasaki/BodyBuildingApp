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
  
  resources :users do
    collection {post :import}
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'edit_base_info'
      patch 'update_base_info'
      get 'index_attendance'
      get 'edit_overwork_request'
      patch 'update_overwork_request'
      get 'notice_overwork_request'
      patch 'update_notice_overwork_request'
      get 'approval_application'
      patch 'update_approval_application'
      
      get 'attendances/edit_one_month'
      get 'attendances/notice_edit_one_month'
      patch 'attendances/update_one_month'
      get 'attendances/edit_one_month_log'
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