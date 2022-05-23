Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root "home#index"

  authenticate :user do
    resources :transport_companies, only: [:show, :edit, :update]
  end

  authenticate :admin do
    resources :transport_companies, only: [:index, :create, :new, :destroy]
  end

  resources :transport_companies, only: [:index, :show, :new, :create]

end
