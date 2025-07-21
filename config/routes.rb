Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :books, only: [:show, :edit, :create, :index, :destroy, :update] do
    resources :post_comments, only: [:create, :destroy]
  end

  get 'home/about', to: 'homes#about', as: 'about'
end
