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
  
  def already_favarited(book)
    self.favorites.exists?(book_id: book.id)
  end

end
