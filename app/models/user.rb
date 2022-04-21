class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4, maximum: 8 }, allow_blank: true
  has_secure_password
  
  has_many :pictures, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
  
  def favorite(picture)
    self.favorites.find_or_create_by(picture_id: picture.id)
  end
  
  def unfavorite(picture)
    favorite = self.favorites.find_by(picture_id: picture.id)
    favorite.destroy if favorite
  end
end