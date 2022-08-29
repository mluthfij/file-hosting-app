Rails.application.routes.draw do
  resources :profiles, only: :show
  devise_for :users
  resources :repos do
    resources :folders, only: [:show, :create, :destroy]
    resources :items, only: [:show, :create, :destroy]
  end
  root 'pages#home'
end
