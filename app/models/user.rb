class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  attachment :profile_image
  validates :name,length: { in: 2..20 } , uniqueness: true
  validates :introduction, length: { maximum: 50 }
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'user_id'
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'target_user_id'
  has_many :followings, through: :active_relationships, source: :target_user
  has_many :followers, through: :passive_relationships, source: :user
  
  include JpPrefecture
  jp_prefecture :prefecture_code  

  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
  def follow(other_user)
    unless self == other_user
      self.active_relationships.find_or_create_by(target_user_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = Relationship.find_by(target_user_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  
  def already_favarited(book)
    self.favorites.exists?(book_id: book.id)
  end

end
