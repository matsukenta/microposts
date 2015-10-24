Rails.application.routes.draw do
  # root pathの定義
  root to: 'static_pages#home'
  
  # /signup　メソッドgetで問い合わせがあったらusersコントローラーのnewアクションへ
  get 'signup', to: 'users#new'
  
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'
  
  # user,micropostモデルのcrudルートを生成
  resources :users
  resources :microposts
  

  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  # favoritesコントローラのリソースを作成
  resources :favorites, only: [:create, :destroy]
  
  resources :users do
    member do
      get 'following'
      get 'followers'
    end
  end
end
