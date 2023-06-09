Rails.application.routes.draw do
  get 'notifications/index'
  get 'groups/index'
  get 'groups/show'
  get 'groups/edit'
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  get "book_comments"=>"books#show"
  
  end
  
  get "search" => "searches#search"
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => 'relationships#followings', as: 'followings'
    get "followers" => 'relationships#followers', as: 'followers'
    get "search" => "users#search"
  end
  
  resources :messages,only: [:create]
  resources :rooms, only: [:create, :show]
  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :user_groups, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  resources :user_groups, only: [:index]
  
  resources :notifications, only: [:index, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

end