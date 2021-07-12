Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  resources :books, only: [:create, :edit, :index, :show, :destroy, :update]
  resources :users, only: [:index, :show, :update, :edit]
  
end
