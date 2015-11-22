Rails.application.routes.draw do
  resources :attendances
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
