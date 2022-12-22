Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  resources :posts, except: %i(new edit)

  #get '/posts', to: 'posts#index'
  #post "/posts", to: "posts#create"
  #get "/posts/:id", to: "posts#show"
  #patch "/posts/:id", to: "posts#update"
  #put "/posts/:id", to: "posts#update"
  #delete "/posts/:id", to: "posts#destroy"

end
