Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "/home/about" => "homes#about", as: "about"

  devise_for :users
  devise_for :users, controllers: {
    sessions: 'sessions'
  }, as: 'another_user_session'

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  get "search" => "searches#search"

  resources :groups, only: [:new, :index, :show, :create, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end