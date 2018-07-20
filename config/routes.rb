Rails.application.routes.draw do
  root to: "owners#index"

  resources :owners do
    resources :machines, only: [:index]
  end

  resources :snacks, only: [:show]

  resources :machines, only: [:show]
end
