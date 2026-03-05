class SurfCondition < ApplicationRecord
  belongs_to :beach
  
  validates :wave_height, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :wind_speed, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  def swell_quality
    return 'flat' if wave_height < 0.3
    return 'poor' if wave_height < 0.5
    return 'fair' if wave_height < 1.0
    return 'good' if wave_height < 1.5
    'excellent'
  end
  
  def wind_type
    return 'offshore' if wind_speed < 10
    return 'cross-shore' if wind_speed < 20
    'onshore'
  end
  
  def wind_direction_label
    directions = {
      0 => 'N', 45 => 'NE', 90 => 'E', 135 => 'SE',
      180 => 'S', 225 => 'SW', 270 => 'W', 315 => 'NW'
    }
    
    closest = directions.keys.min_by { |deg| (deg - (wind_direction || 0)).abs }
    directions[closest]
  end
  
  def good_conditions?
    wave_height >= 0.5 && wind_speed < 25 && swell_quality != 'flat'
  end
end
