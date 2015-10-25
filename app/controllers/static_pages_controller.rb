class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build if logged_in?
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
    end
    # /(root)にアクセスした際に呼び出される
    
    # ログインしているか確認する。(ApplicationControllerのlogged_inメソッドを呼び出している)
    # 
  end
end
