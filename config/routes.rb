Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :packagings
  # resources :users, only: %i[show]
  get '/profile', to: 'users#show'
  get 'scan', to: 'item_users#new'
  get 'barcode', to: 'item_users#barcode', as: :barcode

  resources :items, only: %i[new create show] do
    collection do
      get "find/:barcode", to: "items#find"
    end
  end
  resources :rules
  get '/my_products', to: 'item_users#index'
  get '/my_products/:id', to: 'item_users#show'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
