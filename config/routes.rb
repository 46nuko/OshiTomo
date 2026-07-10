Rails.application.routes.draw do
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
  scope module: :public do
    root to: 'homes#about'
    post "guest_sign_in", to: "guest_sessions#create", as: :guest_sign_in
    resources :posts
    resources :users, only: [:new, :create, :show, :edit, :update, :index] , path_names: { new: 'sign_up' } do
      member do
        patch :withdraw 
      end
    end
    resource :session
    resources :passwords, param: :token
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
