Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :announcements
      resources :users
      root to: "users#index"
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope controller: :static do
    get :terms
    get :privacy
  end

  resources :announcements, only: [:index]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  authenticated :user do
    root "dashboard#show", as: :user_root
  end

  root "static#index"
end
