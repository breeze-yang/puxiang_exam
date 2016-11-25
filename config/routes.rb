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
end

