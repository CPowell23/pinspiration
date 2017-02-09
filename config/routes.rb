Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get '/dashboard', to: "dashboard#index"
#    get '/logout', to: 'sessions#destroy'
#    resources :pins, only: [:destroy]
#    resources :boards, only: [:destroy]
#    resources :comments, only: [:destroy]
#    resources :registered_users, only: [:update]
  end

#  namespace :registered_users, path: ":username" do
#    resources :boards, only: [:index, :new, :create]
#    get '/:name', to: 'boards#show'
#    get '/:name/edit', to: 'boards#edit'
#    patch '/:name', to: 'boards#update'
#    delete '/:name', to: 'boards#destroy'
#    post '/:name/like', to: 'like#create'
#  end
  
#  resources :pins, except: [:index] do
#    post '/comments', to: 'comments#create'
#    post '/comments/like', to: 'like#create'
#    post '/like', to: 'like#create'
#  end
  get '/auth/google', as: :google_login
  get '/auth/google/callback', to: 'sessions#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

#  get '/:username', to: 'registered_users#show'
#  get '/:username/pins', to: 'pins#index'
#
end
