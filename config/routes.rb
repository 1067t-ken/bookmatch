Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about" , as: "about"
    
    resources :users, only: [:show, :index, :update, :edit]
    get 'books', to: "books#index"
    get 'books/:isbn', to: "books#show", as: "book"
    resources :books, only: [:create, :update] do
      resource :favorite, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
    	get "followings" => "relationships#followings", as: "followings"
    	get "followers" => "relationships#followers", as: "followers"
    end
    resources :reviews, only: [:create]
    resources :comments, only: [:create]
  end
  #namespace :admin do
  #  resources :users, only: [:index]
  #end
end
