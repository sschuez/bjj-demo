Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users 
  
  resources :users do
  
    # Pretender Gem
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
    
    resources :comments

    resources :promotions, only: [:new, :create]
  end

  resources :competitions do
    resources :competition_appointments
  end
  
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
