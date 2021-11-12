class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  # フォローしている人取得
  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower

  # フォローされている人取得
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  # バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(folowing_id: other_user.id)
    end
  end

  # ユーザーのフォローを外す
  def unfollow(other_user)
    relationship = self.relationships.find_or_create_by(folowing_id: other_user.id)
    relationship.destroy if relationship
  end

  # フォローしているかの確認
  def following?(other_user)
    self.followings.include?(other_user)
  end
end