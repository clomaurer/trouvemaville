Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cities, only: [:index, :show]
  resources :favorites, only: [:create, :destroy, :show]
  resources :saved_searches, only: [:create, :edit, :update, :destroy]
  resource :comparator, only: [:show]
end
