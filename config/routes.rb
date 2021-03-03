Rails.application.routes.draw do
  root to: 'sessions#new'
  # user authentication
  resources :sessions, only: %i[index]
  get    '/sign_in', to: 'sessions#new'
  post   '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  resources :admins, only: %i[index]

  # api
  namespace :api do
    namespace :v1 do
      post '/sign_in', to: 'users#sign_in'
      post '/sign_up', to: 'users#sign_up'
      resources :admins, only: %i[index]
      get '/admins/call', to: 'admins#call'
    end
  end
end
