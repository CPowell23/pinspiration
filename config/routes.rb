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

  get '/password_reset', to: 'passwords#new'
  post '/password_reset', to: 'passwords#verify'
  put '/password_reset', to: 'passwords#verify_confirm', as: "update_password"

  resources :pins, except: [:index] do
    resources :comments, only: [:new, :create, :destroy], :controller => "pins/comments"
  #  post '/comments', to: 'comments#create'
  #  post '/comments/like', to: 'like#create'
    post '/comments/:comment_id/like', to: 'pins/comments_like#create', as: 'comment_like'
    delete '/comments/:comment_id/like/:id', to: 'pins/comments_like#destroy', as: 'comment_unlike'
    post '/like', to: 'pins/like#create', as: 'like'
    delete '/like/:id', to: 'pins/like#destroy', as: 'unlike'
 end

  get '/auth/google_oauth2', as: :google_login
  get '/o/oauth2/auth', as: :google_login_test
  get '/auth/google_oauth2/callback', to: 'google_sessions#create'
  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/:username/edit', to: 'registered_users#edit', as: 'edit_registered_user'
  patch '/:username/deactiveate', to: 'registered_users#deactivate', as: 'deactivate_registered_user'

  resources :pinspiration_credentials, only: [:new, :create, :update]

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
    delete '/:name', to: 'boards#destroy', as: "delete_board"
    post '/:name/like', to: 'like#create', as: "board_like"
    delete '/:name/like/:id', to: 'like#destroy', as: 'board_unlike'
  end

  get '/:username', to: 'registered_users#show', as: "registered_user"
  get '/:username/pins', to: 'pins#index', as: 'pins_index'
  delete '/:username', to: 'registered_users#destroy'

  namespace :api do
    namespace :v1 do
      namespace :pins do
        get '/:id/comments', to: 'comments#index'
        get '/:id/comments/:comment_id', to: 'comments#show'
        post '/:id/comments', to: 'comments#create'
        put '/:id/comments/:comment_id', to: 'comments#update'
        delete '/:id/comments/:comment_id', to: 'comments#destroy'
      end
    end
  end
end
