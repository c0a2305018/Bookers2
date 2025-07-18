Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  
  resources :users, only: [:index, :show, :edit, :update] do
  end
  resources :books, only: [:show, :edit,:create,:index,:destroy,:update]
  get 'home/about', to: 'homes#about', as: 'about'
end
