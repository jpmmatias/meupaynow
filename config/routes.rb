Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root 'home#index'

  resources :dashboard, only: [:index], path:"home"
  resources :payment_methods, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :companies, only: [:new , :create, :show] do
    get 'regenerate_token', on: :member
  end

end
