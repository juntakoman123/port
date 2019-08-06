Rails.application.routes.draw do


#ログイン画面
  get 'sessions/login'
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


end
