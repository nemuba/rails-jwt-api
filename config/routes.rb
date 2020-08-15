Rails.application.routes.draw do
  root to: "apipie/apipies#index"

  namespace :api do
    namespace :v1 do
      resources :users

      resources :posts do
        resources :comments

        member do
          post '/like', to: 'likes#create'
          delete '/dislike', to: 'likes#destroy'
        end
      end 
      
      post '/auth/login', to: 'authentication#login'
      get '/*a', to: 'api#not_found'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
