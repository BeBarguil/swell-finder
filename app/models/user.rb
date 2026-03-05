class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_beaches, through: :favorites, source: :beach

  validates :name, presence: true

  def favorited?(beach)
    favorite_beaches.include?(beach)
  end
end
