Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end
  resources :lessons, only: [:show]
  namespace :instructor do
    resources :lessons, only: [:update]
    resources :sections, only: [] do
      resources :lessons, only: [:new, :create, :edit, :update, :destroy]
    end
    resources :courses, only: [:new, :create, :edit, :update, :show, :destroy] do
      resources :sections, only: [:new, :create, :edit, :update, :destroy]
    end    
  end
end
