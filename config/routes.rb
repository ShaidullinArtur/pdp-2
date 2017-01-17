Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :companies, only: %w(index new create)

  constraints(Subdomain) do
    devise_for :users, controllers: { registrations: "users/registrations" }

    scope module: :companies do
      match "/", to: "posts#index", via: :get
      resource :settings, only: %i(show update)
      resources :users, only: :index
      resources :posts do
        resources :comments, only: %i(index create update destroy), module: :posts
        resource :rating, only: :update, module: :posts, controller: :rating
      end
    end
  end

  root to: "companies#index"
end
