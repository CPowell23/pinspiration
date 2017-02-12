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

  get '/password-resets', to: 'password_resets#index', as: 'password-resets'
  get '/password-reset', to: 'password_reset#show', as: 'password-reset'
  get '/password-confirmation', to: 'password_confirmation#show', as: 'password-confirmation'
  get '/auth/google_oauth2', as: :google_login
  get '/o/oauth2/auth', as: :google_login_test
  get '/auth/google_oauth2/callback', to: 'google_sessions#create'
  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :pins, except: [:index] do
    resources :comments, only: [:new, :create, :destroy], :controller => "pins/comments"
  #  post '/comments', to: 'comments#create'
  #  post '/comments/like', to: 'like#create'
  #  post '/like', to: 'like#create'
  end

  namespace :registered_users, path: ":username" do
    resources :boards, only: [:index]
    resources :pins, only: [:index]
    get "/:name", to: "boards#show", as: "board"
#    resources :boards, only: [:index, :new, :create]
#    get '/:name/edit', to: 'boards#edit'
#    patch '/:name', to: 'boards#update'
#    delete '/:name', to: 'boards#destroy'
#    post '/:name/like', to: 'like#create'
  end

  get '/:username', to: 'registered_users#show'
  get '/:username/pins', to: 'pins#index', as: 'pins_index'

end
