class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @beaches = current_user.favorite_beaches.includes(:surf_conditions)
  end

  def create
    @beach = Beach.find(params[:beach_id])
    current_user.favorites.create(beach: @beach)
    redirect_back(fallback_location: root_path, notice: 'Praia adicionada aos favoritos!')
  end

  def destroy
    @favorite = current_user.favorites.find_by(beach_id: params[:beach_id])
    @favorite.destroy if @favorite
    redirect_back(fallback_location: root_path, notice: 'Praia removida dos favoritos!')
  end
end
