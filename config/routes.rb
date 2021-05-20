Rails.application.routes.draw do
  devise_for :users
  get "/", to: 'pages#home', as: "home"
  resources :cities, only: [:index, :show] do
    resources :favorites, only: [:create]
    resources :compared_cities, only: [:create]
  end
  resources :favorites, only: [:destroy, :index, :show]
  resources :saved_searches, only: [:create, :destroy]
  resource :comparator, only: [:show]
  resources :compared_cities, only: [:destroy]
end
