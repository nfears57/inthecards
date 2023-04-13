Rails.application.routes.draw do
  resources :games, only: [:index, :show]
  resources :wagers, only: [:create, :show]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  get 'cards/:deck_id/draw', to: 'cards#draw'
  get 'decks/new/shuffle', to: 'decks#shuffle'
  get 'decks/:deck_id/reshuffle', to: 'decks#reshuffle'
  delete "/logout", to: "sessions#destroy"
  get "/me/:id", to: "users#show"
  post "/login", to: 'sessions#create'
  get '/login', to: 'sessions#is_logged_in?'
  post '/create-account', to: 'users#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
