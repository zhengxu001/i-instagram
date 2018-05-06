Rails.application.routes.draw do
  root to: "home#index"
  get 'home/authenticated' => "home#authenticated"
  resources :users
  get 'callback' => "users#callback"
  get 'connect' => "users#connect"
  # get 'authorize2' => "users#authorize2"
end
