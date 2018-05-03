Rails.application.routes.draw do
  resources :users
  get 'authorize1' => "users#authorize1"
  get 'authorize2' => "users#authorize2"
end
