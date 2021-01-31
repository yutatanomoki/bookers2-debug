Rails.application.routes.draw do
  get 'reviews/index'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  get "search" => "searchs#index", as: "search"
  resources :users,only: [:show,:index,:edit,:update] do
    resources :relationships, only: [:create, :destroy]
    resources :followers
    resources :followings
    #get :search
  end
  resources :books, only: [:new, :create, :index, :show,:edit,:update,:destroy] do
    resources :book_comments, only: [:create, :destroy]
    resources :reviews, only: [:index, :create]
    resource :favorites, only: [:create, :destroy]
    #get :search
  end
end