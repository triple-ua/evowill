Rails.application.routes.draw do
  get '/index', to: 'tickets#index'
  get '/show/:id', to: 'tickets#show'

  post '/json', to: 'consumer#json'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
