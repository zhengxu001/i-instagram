Rails.application.routes.draw do
  root to: "home#index"
  get 'home/authenticated'
  resources :users, only: [:show, :destroy] do
    collection do
      get 'callback'
      get 'connect'
    end
  end
end
