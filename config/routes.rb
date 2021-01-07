Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resources :relationships, only: [:create, :destroy]
    resources :followers
    resources :followings
  end
  resources :books, only: [:new, :create, :index, :show,:edit,:update,:destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end