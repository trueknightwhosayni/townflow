Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: 'dashboard#index'

    resources :users
    resources :groups
    resources :roles

    namespace :anything do
      resources :collections do
        resources :forms
        resources :fields
        resources :views
      end
      resources :folders, only: [:new, :create, :edit, :update, :destroy]

      resources :dynamic_form_components, only: [:index]
    end
  end

  root to: 'dashboard#index'
end
