Rails.application.routes.draw do
  root 'home#index'

  resources :subreddits, only: [:show], path: '/r/', param: :name

  get '/reddit/login', to: 'sessions#reddit_user_auth', as: :login
  delete '/reddit/logout', to: 'sessions#destroy', as: :logout
  get '/auth/reddit/callback', to: 'sessions#process_auth_response'
end
