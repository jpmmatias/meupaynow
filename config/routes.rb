Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :dashboard, only: [:index]
  root 'home#index'
end
