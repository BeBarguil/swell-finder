class BeachesController < ApplicationController
  def index
    if params[:lat].present? && params[:lng].present?
      user_lat = params[:lat].to_f
      user_lng = params[:lng].to_f
      
      # Buscar todas as praias e calcular distância
      all_beaches = Beach.all.map do |beach|
        distance = beach.distance_from(user_lat, user_lng)
        [beach, distance]
      end
      
      # Ordenar por distância e pegar as 9 mais próximas
      @beaches = all_beaches
        .sort_by { |beach, distance| distance }
        .first(9)
        .map { |beach, distance| beach }
      
      @user_location = { lat: user_lat, lng: user_lng }
    else
      @beaches = Beach.all.limit(9)
    end
  end

  def show
    @beach = Beach.find(params[:id])
  end
end
