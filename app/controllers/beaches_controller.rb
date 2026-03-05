class BeachesController < ApplicationController
  def index
    @beaches = Beach.includes(:surf_conditions).all
    
    if params[:lat].present? && params[:lng].present?
      latitude = params[:lat].to_f
      longitude = params[:lng].to_f
      
      # Buscar praias em um raio de 100km
      @beaches = Beach.all.select do |beach|
        beach.distance_from(latitude, longitude) <= 100
      end.sort_by { |beach| beach.distance_from(latitude, longitude) }
      
      @user_location = { lat: latitude, lng: longitude }
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @beaches.map { |beach| beach_json(beach) } }
    end
  end
  
  def show
    @beach = Beach.find(params[:id])
    @current_conditions = @beach.current_conditions
    @recent_conditions = @beach.surf_conditions.order(created_at: :desc).limit(10)
    
    respond_to do |format|
      format.html
      format.json { render json: beach_json(@beach) }
    end
  end
  
  private
  
  def beach_json(beach)
    conditions = beach.current_conditions
    
    {
      id: beach.id,
      name: beach.name,
      city: beach.city,
      state: beach.state,
      latitude: beach.latitude,
      longitude: beach.longitude,
      difficulty_level: beach.difficulty_level,
      difficulty_label: beach.difficulty_label,
      description: beach.description,
      distance: @user_location ? beach.distance_from(@user_location[:lat], @user_location[:lng]) : nil,
      current_conditions: conditions ? {
        wave_height: conditions.wave_height,
        wave_height_formatted: conditions.wave_height_formatted,
        wave_period: conditions.wave_period,
        wave_direction: conditions.wave_direction_text,
        wind_speed: conditions.wind_speed,
        wind_speed_formatted: conditions.wind_speed_formatted,
        wind_direction: conditions.wind_direction_text,
        wind_type: conditions.wind_type,
        swell_quality: conditions.swell_quality,
        good_conditions: conditions.good_conditions?,
        updated_at: conditions.created_at
      } : nil
    }
  end
end
