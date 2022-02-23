Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"

  resources :articles do
    resources :comments
  end

  # /auth
  get '/register', to: 'auth#register'
  post '/register', to: 'auth#register'
  get '/login', to: 'auth#login'
  post '/login', to: 'auth#login'
  get '/logout', to: 'auth#logout'

  resources :tasks do
    member do
      get 'complete'
    end
  end

  resources :intervals
end
