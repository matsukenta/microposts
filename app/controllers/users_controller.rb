class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :following, :followers]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクトする。
      redirect_to root_path 
    else
      # 保存に失敗した場合は編集画面へ戻す。
      render 'edit'
    end
  end

  # フォローしているユーザを表示
  def following
    @followings = @user.following_users
  end
  
  # フォローされているユーザを表示
  def followers
    @followers = @user.follower_users 
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile, :phone_number)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
