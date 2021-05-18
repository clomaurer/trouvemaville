Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cities, only: [:index, :show] do
    resources :favorites, only: [:create]
    resources :compared_cities, only: [:create]
  end
  resources :favorites, only: [:destroy, :index, :show]
  resources :saved_searches, only: [:create, :destroy]
  resource :comparator, only: [:show]
  resources :compared_cities, only: [:destroy]
end
