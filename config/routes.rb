Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :dashboard, only: [:index], path:"home"
  resources :payment_methods, only: [:index, :new, :create, :edit, :update]
  resources :companies, only: [:new , :create]
  root 'home#index'
end
