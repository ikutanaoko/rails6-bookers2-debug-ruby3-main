Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/edit'
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  get "book_comments"=>"books#show"
  
  end
  
  get "search" => "searches#search"
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    
  end
  
  resources :messages,only: [:create]
  resources :rooms, only: [:create, :show]
  resources :groups do
  get "join" => "groups#join"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end