Rails.application.routes.draw do
  root   'meetups#index'

  resource :account, controller: :account
  scope :account do
    get    '/sign_up', to: 'account#new'
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
  end
  resources :meetups do
    resources :replies
  end

  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      resources :meetups, only: [:index]
    end
  end
end

