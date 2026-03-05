class BeachesController < ApplicationController
  def index
    @max_distance = params[:distance].present? ? params[:distance].to_i : nil
    
    if params[:lat].present? && params[:lng].present?
      user_lat = params[:lat].to_f
      user_lng = params[:lng].to_f
      
      # Buscar todas as praias e calcular distância
      all_beaches = Beach.all.map do |beach|
        distance = beach.distance_from(user_lat, user_lng)
        { beach: beach, distance: distance }
      end
      
      # Filtrar por distância se especificado
      if @max_distance
        all_beaches = all_beaches.select { |b| b[:distance] <= @max_distance }
      end
      
      # Ordenar por distância
      @beaches_with_distance = all_beaches.sort_by { |b| b[:distance] }
      @beaches = @beaches_with_distance.map { |b| b[:beach] }
      
      @user_location = { lat: user_lat, lng: user_lng }
      @total_found = @beaches.count
    else
      @beaches = Beach.all.limit(9)
      @beaches_with_distance = []
    end
  end

  def show
    @beach = Beach.find(params[:id])
  end
end
