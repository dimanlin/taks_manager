Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :users, only: [:index, :show]
  resources :tasks do
    member do
      post :assign_to_me
    end
  end

  namespace :dashboard do
    resources :users do
      member do
        get :edit_password
        post :update_password
      end
    end
    resources :tasks
  end

  root 'welcome#index'
end
