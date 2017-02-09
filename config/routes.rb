Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get '/dashboard', to: "dashboard#index"
#    resources :pins, only: [:destroy]
#    resources :boards, only: [:destroy]
#    resources :comments, only: [:destroy]
#    resources :registered_users, only: [:update]
  end

  resources :pins, except: [:index]  do
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
 
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/:username', to: 'registered_users#show'

  get '/:username', to: 'registered_users#show', as: 'registered_user'
#  get '/:username/pins', to: 'pins#index'
#
end
