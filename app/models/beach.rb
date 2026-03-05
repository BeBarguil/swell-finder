class Beach < ApplicationRecord
  has_many :surf_conditions, dependent: :destroy
  
  validates :name, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :difficulty_level, presence: true, inclusion: { in: %w[beginner intermediate advanced] }
  
  # Scope para buscar praias próximas de uma localização
  scope :near, ->(latitude, longitude, distance = 50) {
    where(
      "ST_DWithin(
        ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)::geography,
        ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography,
        ?
      )",
      longitude, latitude, distance * 1000 # Convert km to meters
    ).order(
      Arel.sql(
        "ST_Distance(
          ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)::geography,
          ST_SetSRID(ST_MakePoint(#{longitude}, #{latitude}), 4326)::geography
        )"
      )
    )
  }
  
  # Método para calcular distância de um ponto
  def distance_from(lat, lng)
    # Fórmula de Haversine simplificada
    rad_per_deg = Math::PI / 180
    rkm = 6371 # Earth radius in kilometers
    
    dlat_rad = (lat - latitude) * rad_per_deg
    dlon_rad = (lng - longitude) * rad_per_deg
    
    lat1_rad = latitude * rad_per_deg
    lat2_rad = lat * rad_per_deg
    
    a = Math.sin(dlat_rad / 2)**2 + 
        Math.cos(lat1_rad) * Math.cos(lat2_rad) * 
        Math.sin(dlon_rad / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    
    (rkm * c).round(2)
  end
  
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
end
