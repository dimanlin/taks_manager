Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :users, only: [:index, :show]

  namespace :dashboard do
    resources :api, only: :index
    resources :users do
      member do
        get :edit_password
        post :update_password
      end
    end
    resources :tasks do
      member do
        post :assign_to_me
      end
      resources :attachments, only: :destroy
    end
  end

  root 'welcome#index'
end
