class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :following, :followers, :favorites]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).order(created_at: :desc).per(5)
  end
  
  # @userインスタンスをUserクラスを用いて生成
  def new
    @user = User.new
  end
  
  # Userモデルを送られてきた（user_params）で作成して@userに格納
  # dbに登録できたら、welcome to the Sample App!を表示し、
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      # slack確認中
      redirect_to @user
    else
      # user viewのnew.html.erbを参照
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
  
  # お気に入りされている投稿を表示
  def favorites
    @favorites = @user.favoriting_microposts.page(params[:page]).order(created_at: :desc).per(5)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile, :phone_number)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
