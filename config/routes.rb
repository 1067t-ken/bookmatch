Rails.application.routes.draw do
  devise_for :users
  
  devise_for :admins, path: "admin", skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about" , as: "about"
    
    resources :users, only: [:show, :index, :update, :edit, :destroy]
    get 'books', to: "books#index"
    get 'books/:isbn', to: "books#show", as: "book"
    resources :books, only: [:create, :update] do
      resource :favorite, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      member do
      	get "followings"
      	get "followers"
      	get "favorites"
      end
    end
    resources :reviews, only: [:create]
    resources :comments, only: [:create]
  namespace :public do
  resources :users, only: [:edit, :update]
  end
  end
  namespace :admin do
    root to: "users#index"
    resources :users, only: [:index, :show, :destroy]
    resources :reviews, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end
  

 
  #namespace :admin do
  #  get 'dashboards', to: 'dashboards#index'
  #end
end
