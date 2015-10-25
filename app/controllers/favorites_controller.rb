class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    #お気に入り登録
    def create
        @user = User.find(params[:favmicropost_id])
        current_user.favorite(@user)
    end
    
    #お気に入り削除
    def destroy
        @user = current_user.favoriting_favorites.find(params[:id]).favmicropost
        current_user.unfavorite(@user)
    end
    
end
