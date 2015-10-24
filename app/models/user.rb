class User < ActiveRecord::Base
    include JpPrefecture
    jp_prefecture :area

    # validationの追加 #
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

    validates :profile, length: { maximum: 255 }
    
    #=============================#
    
    # has_secure_passwordを追加することで、
    # データベースに安全にハッシュ化（暗号化）されたpassword_digestを保存する。
    # passwordとpassword_confirmationをモデルに追加して、パスワードの確認が一致するか検証する。
    # パスワードが正しいときに、ユーザーを返すauthenticateメソッドを提供する。
    has_secure_password
    #=============================#
    
    has_many :microposts
    
    
    # お気に入り
    has_many :following_relationships, class_name:  "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
    
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
    
    has_many :follower_users, through: :follower_relationships, source: :follower
    
        
    # お気に入り
    has_many :favoriting_favorites, class_name:  "Favorite",
                                    foreign_key: "favuser_id",
                                    dependent:   :destroy
    has_many :favoriting_microposts, through: :favoriting_favorites, source: :favmicropost
    #===========================
    
    
    
    # 他のユーザーをフォローする
    def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
    end
    
    # フォローしているユーザーをアンフォローする。
    def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
    end
    
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    

    # お気に入りを登録する
    def favorite(other_micropost)
        favoriting_favorites.create(favmicropost_id: other_micropost.id)
    end
    
    # お気に入りを削除する
    def unfavorite(other_micropost)
        favoriting_favorites.find_by(favmicropost_id: other_micropost.id).destroy
    end
    
    # お気に入り登録をしているかどうか？
    def favoriting?(other_micropost)
        favoriting_microposts.include?(other_micropost)
    end
    
    
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
end
