class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    #お気に入り登録
    def create
        @micropost = Micropost.find(params[:favmicropost_id])
        current_user.favorite(@micropost)
    end
    
    #お気に入り削除
    def destroy
        @micropost = current_user.favoriting_favorites.find(params[:id]).favmicropost
        current_user.unfavorite(@micropost)
    end
    
end
