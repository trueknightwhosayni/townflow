Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: 'dashboard#index'

    resources :users
    resources :groups
    resources :roles

    namespace :anything do
      resources :collections
      resources :folders, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  root to: 'dashboard#index'
end
