Rails.application.routes.draw do
  # delete '/profiles/:id/destroy_post/:id', to: 'profiles#destroy_post', as: 'destroy_post', :via => :delete
  patch 'repos/:id', to: 'repos#private_fiture', as: 'private_fiture', :via => :update
  resources :profiles, only: :show
  devise_for :users
  resources :repos do
    resources :folders, only: [:show, :create, :destroy]
    resources :items, only: [:show, :create, :destroy]
  end
  root 'pages#home'
end
