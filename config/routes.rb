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

  resources :billings, only: [:index, :show, :update] do
    get 'edit_status', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :companies, only: [] do
        resources :customers, only: [:index, :show, :create]
      end
      resources :products, only: [] do
        resources :billings, only: [:create], param: :token
      end
    end
  end

end
