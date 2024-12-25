Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "/home/about" => "homes#about", as: "about"

  devise_for :users
  devise_for :users, controllers: {
    sessions: 'sessions'
  }, as: 'another_user_session'
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update]
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end