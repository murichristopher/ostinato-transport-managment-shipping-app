Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root "home#index"

  authenticate :admin do
    resources :transport_companies
  end

  resources :transport_companies, only: [:index, :show, :new, :create]

end
