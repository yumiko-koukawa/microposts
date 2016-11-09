Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # get '/(:locale)' => 'layouts#application'
  # scope "/(:locale)", locale: /en|ja/ do
  #   resources :users
  #   resource :sessions
  # end
  
  resources :users do
    member do
      get :followings, :followers, :favorites
    end
  end
  resources :microposts do
    member do
      post :retweet
    end
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  end