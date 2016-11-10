Rails.application.routes.draw do

  resources :companies, only: %w(index new create)

  constraints(Subdomain) do
    devise_for :users, controllers: { registrations: "users/registrations" }
    scope module: :companies do
      match "/", to: "dashboard#show", via: :get
      resource :settings, only: %i(show update)
    end
  end

  root to: "companies#index"
end
