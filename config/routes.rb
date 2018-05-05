Rails.application.routes.draw do
  root to: "home#index"
  get 'home/authenticated' => "home#authenticated"
  resources :users
  get 'callback' => "users#callback"
  get 'authorize1' => "users#authorize1"
  get 'authorize2' => "users#authorize2"
end
