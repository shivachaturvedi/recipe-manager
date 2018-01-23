Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'

  resources :recipes do
    member do
      post 'like'
    end
  end
  
  resources :chefs do
    member do
      get 'follow'
    end
  end
  
  resources :chefs do
    member do
      get 'unfollow'
    end
  end
  
  resources :chefs, except: [:new]
  resources :users
  
  get '/register', to: 'chefs#new'
  
  get '/login', to: "logins#new"
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"
  
  resources :styles, only: [:new, :create, :show]
  resources :ingredients, only: [:new, :create, :show]

end
