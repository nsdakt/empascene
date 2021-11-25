Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search', to: 'searches#search'

  resources :posts, only: %i[index show new edit create update destroy] do
    resource :favorites, only: %i[create destroy]
    resources :post_comments, only: %i[create destroy]
  end

  resources :users, only: %i[show edit update] do
    # お気に入り一覧
    member do
      # お気に入り一覧
      get :favorites
      # 退会確認画面
      get 'unsubscribe'
      # 論理削除用のルーティング
      patch 'withdrawal'
    end

    # フォロー機能
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
