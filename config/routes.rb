Rails.application.routes.draw do


#ログイン画面
  get 'sessions/new'
  post 'sessions' => 'sessions#create'
  delete 'sessions' => 'sessions#destroy'

# 新規登録ページ
  resources :signups,only: [:new]

#  ホーム
  root to: 'tweets#index'

# 非ログイン時のホーム
  get 'registrations/new'

# user
  namespace :api, {format: 'json'} do
      resources :users, only: [:index,:show,:create,:update]
  end

# tweet
  namespace :api, {format: 'json'} do
    resources :tweets, only: [:index,:create,:destroy]
  end

# いいね
  namespace :api, {format: 'json'} do
    resources :favorites, only: [:create,:destroy,:show]
  end

# フォロー機能
  namespace :api, {format: 'json'} do
    resources :follows, only: [:create,:destroy]
  end

  # フォロー一覧
  namespace :api, {format: 'json'} do
    resources :followings, only: [:show]
  end

  # フォロワー一覧
  namespace :api, {format: 'json'} do
    resources :followers, only: [:show]
  end

  # 設定画面
  namespace :api, {format: 'json'} do
    resources :settings, only: [:index]
  end

  namespace :api, {format: 'json'} do
    patch "settings" => "settings#update"
  end






end
