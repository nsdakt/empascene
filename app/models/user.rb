class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  # 自分がフォローしている側の関係性（与フォロー）
  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  # 自分がフォローされている側の関係性（被フォロー）
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # フォローしている人の取得
  has_many :followings, through: :active_relationships, source: :follower
  # フォローされている人の取得
  has_many :followers, through: :passive_relationships, source: :following

  # バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # フォローしているかの確認
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end