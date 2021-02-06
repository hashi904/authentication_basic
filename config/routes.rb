Rails.application.routes.draw do
  root to: 'sessions#new'
  # user authentication
  resources :sessions, only: %i[index]
  get    '/sign_in', to: 'sessions#new'
  post   '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
