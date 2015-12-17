Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
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
  end

  root 'welcome#index'
end
