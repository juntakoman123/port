Rails.application.routes.draw do

  get 'sessions/login' #ログイン画面
  post 'sessions' => 'sessions#create'
  resources :signups,only: [ :new, :create] # 新規登録ページ
  get 'registrations/new' # ホーム
  root to: 'tweets#index' # ルート

  namespace :api, {format: 'json'} do
      resources :users, only: [:index, :show,:create,:update]
  end

end
