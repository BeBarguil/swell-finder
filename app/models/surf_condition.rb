class SurfCondition < ApplicationRecord
  belongs_to :beach
  
  validates :wave_height, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :wave_period, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :wave_direction, numericality: { greater_than_or_equal_to: 0, less_than: 360, allow_nil: true }
  validates :wind_speed, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :wind_direction, numericality: { greater_than_or_equal_to: 0, less_than: 360, allow_nil: true }
  
  # Retorna se as condições são boas para surf
  def good_conditions?
    return false if wave_height < 0.5
    return false if wind_speed && wind_speed > 25
    true
  end
  
  # Classifica a qualidade do swell
  def swell_quality
    return 'Sem ondas' if wave_height < 0.3
    return 'Flat' if wave_height < 0.5
    return 'Pequeno' if wave_height < 1.0
    return 'Bom' if wave_height < 1.5
    return 'Ótimo' if wave_height < 2.5
    'Excelente'
  end
  
  # Tipo de vento
  def wind_type
    return 'N/A' unless wind_direction && beach.present?
    
    # Simplificado: offshore (terral) é bom, onshore (maral) é ruim
    # Na prática, você precisaria da direção da praia
    if wind_speed < 5
      'Leve'
    elsif wind_speed < 15
      'Moderado'
    elsif wind_speed < 25
      'Forte'
    else
      'Muito Forte'
    end
  end
  
  def wave_height_formatted
    "#{wave_height.round(1)}m"
  end
  
  def wind_speed_formatted
    return 'N/A' unless wind_speed
    "#{wind_speed.round(0)} km/h"
  end
  
  # Direção do vento em texto
  def wind_direction_text
    return 'N/A' unless wind_direction
    
    directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
    index = ((wind_direction + 22.5) / 45).to_i % 8
    directions[index]
  end
  
  # Direção das ondas em texto
  def wave_direction_text
    return 'N/A' unless wave_direction
    
    directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
    index = ((wave_direction + 22.5) / 45).to_i % 8
    directions[index]
  end
end
