Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:show, :edit, :update]

  resources :posts do
   resource :favorites, only: [:create, :destroy]

   resources :post_comments, only: [:create, :destroy]
  end
end
