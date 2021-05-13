Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cities, only: [:index, :show] do
    resources :favorites, only: [:create]
  end
  resources :favorites, only: [:destroy, :index, :show]
  resources :saved_searches, only: [:index, :create, :edit, :update, :destroy]
  resource :comparator, only: [:show]
end
