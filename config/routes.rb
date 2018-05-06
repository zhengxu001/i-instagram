Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/authenticated'
  resources :users, only: %i[show destroy] do
    collection do
      get 'callback'
      get 'connect'
    end
  end
end
