Rails.application.routes.draw do
  resources :employees
  resources :attendances
  root to: 'employees#index'
  devise_for :users
  resources :users
end
