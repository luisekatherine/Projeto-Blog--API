Rails.application.routes.draw do
post "/user", to: 'users#create'
put "/user", to: 'users#update'
delete "/user", to: 'users#destroy'
post "/login", to: 'users#login'
get "/auto_login", to: "users#auto_login"
get "/user/:id", to: "users#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  post '/posts/:post_id/like', to: 'likes#create_like_post'
  post '/posts/:post_id/comments/:comment_id/like', to: 'likes#create_like_comment'
  delete '/posts/:post_id/like/:id', to: 'likes#destroy_like_post'
  delete '/posts/:post_id/comments/:comment_id/like/:id', to: 'likes#destroy_like_comment'

  resources :posts, except: %i(new edit) do
    resources :comments, except: %i(new edit)
    end
  resources :tags, except: %i(new edit)
  post 'posts/:id/tag', to: 'posts#link_tag'
  delete 'posts/:id/tag/:tag_id', to: 'posts#unlink_tag'
  get 'posts/:id/tags', to: 'posts#tags_view'  
 # mesma coisa que post 'posts/:id/tag', controller: :posts, action :link_tag

end