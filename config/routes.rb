Rails.application.routes.draw do
  root to: 'sessions#new'
  # user authentication
  resources :sessions, only: %i[index]
  get    '/sign_in', to: 'sessions#new'
  post   '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
end
