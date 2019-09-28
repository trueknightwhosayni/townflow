Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: 'dashboard#index'

    resources :users
    resources :groups
    resources :roles
  end

  root to: 'dashboard#index'
end
