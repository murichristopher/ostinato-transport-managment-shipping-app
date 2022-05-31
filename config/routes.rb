Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root "home#index"

  authenticate :admin do
    resources :transport_companies
  end

  authenticate :user do
    resources :carrier_vehicles
    resources :prices
    resources :delivery_times
    resources :work_order_routes, only: [:index, :show, :new, :create, :destroy]
  end

  resources :transport_companies do
    member do
      patch :toggle_status
    end
  end

  resources :work_orders, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :budget
      get :new_budget
      get :search
      post :handle_search
    end
    member do
      get :new_directly_assign
      post :create_directly_assign
      get :new_budget_assign
      post :create_budget_assign
      post :handle_search
      patch :accept
      patch :refuse
    end
  end



  # resources :transport_companies, only: [:index, :show, :new, :create, :edit, :update]
  # resources :carrier_vehicles, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # resources :prices, param: :slug
  # resources :delivery_times, param: :slug
end
