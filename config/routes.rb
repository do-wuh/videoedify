Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :courses, only: [:index, :show]
  resources :lessons, only: [:show]
  namespace :instructor do
    resources :courses, only: [:new, :create, :edit, :update, :show, :destroy] do
      resources :sections, only: [:new, :create, :edit, :update, :show, :destroy]
    end
    resources :sections, only: [] do
      resources :lessons, only: [:new, :create, :edit, :update, :show, :destroy]
    end
  end
end
