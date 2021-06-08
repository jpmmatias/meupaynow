Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :dashboard, only: [:index]
  resources :companies, only: [:new , :create]
  root 'home#index'
end
