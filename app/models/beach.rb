class Beach < ApplicationRecord
  has_many :surf_conditions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user
  
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  
  def current_conditions
    surf_conditions.order(created_at: :desc).first
  end
  
  def difficulty_label
    {
      'beginner' => 'Iniciante',
      'intermediate' => 'Intermediário',
      'advanced' => 'Avançado/Profissional'
    }[difficulty_level]
  end
  
  def distance_from(lat, lng)
    lat1_rad = lat * Math::PI / 180
    lat2_rad = latitude * Math::PI / 180
    delta_lat = (latitude - lat) * Math::PI / 180
    delta_lng = (longitude - lng) * Math::PI / 180
    
    a = Math.sin(delta_lat/2) * Math.sin(delta_lat/2) +
        Math.cos(lat1_rad) * Math.cos(lat2_rad) *
        Math.sin(delta_lng/2) * Math.sin(delta_lng/2)
    
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    
    6371 * c
  end
end
