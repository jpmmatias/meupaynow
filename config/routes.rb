Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root 'home#index'

  resources :dashboard, only: [:index], path:"home"
  resources :payment_methods, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :companies, only: [:new , :create, :show, :index, :edit, :update] do
    get 'regenerate_token', on: :member
    resources :company_payments_methods, only: [:index, :new, :create]
    resources :products, only: [:index, :show, :new, :create, :edit, :update]
  end
  resources :clients, only: [:index, :show] do
    get 'request_change_status', on: :member
  end
  resources :status_requests, only: [] do
    get 'change', on: :member
  end

end
