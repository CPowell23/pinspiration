Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get '/dashboard', to: "dashboard#index"
    resources :pins, only: [:destroy]
    resources :boards, only: [:destroy]
    resources :comments, only: [:destroy]
    # resources :registered_users, only: [:update]
  end

  resources :pins, except: [:index] do
    resources :comments, only: [:new, :create, :destroy], :controller => "pins/comments"
  #  post '/comments', to: 'comments#create'
  #  post '/comments/like', to: 'like#create'
  #  post '/like', to: 'like#create'
  end

  get '/auth/google_oauth2', as: :google_login
  get '/o/oauth2/auth', as: :google_login_test
  get '/auth/google_oauth2/callback', to: 'google_sessions#create'
  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :registered_users, path: ":username" do
    get "/following", to: "following#index"
    post "/following/:username_of_user_being_followed", to: "following#create", as: "following_create"
    delete "/following/:username_of_user_being_followed", to: "following#destroy", as: "following_destroy"
    get "/followers", to: "followers#index"
    resources :boards, only: [:index, :new, :create]
    resources :pins, only: [:index]
    get "/:name", to: "boards#show", as: "board"
    get '/:name/edit', to: 'boards#edit', as: "edit_board"
    patch '/:name', to: 'boards#update'
  end

  get '/:username', to: 'registered_users#show', as: "registered_user"
  get '/:username/pins', to: 'pins#index', as: 'pins_index'
end
