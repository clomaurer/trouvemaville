class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorites = FavoriteCity.where(user: current_user)
  end

  def create
    @city = City.find(params[:city_id])
    favorite = FavoriteCity.find_by(city: @city, user: current_user)
    if favorite.present?
      favorite.destroy
    else
      @favorite = FavoriteCity.new
      @favorite.user = current_user
      @favorite.city = @city
      @favorite.save
    end
    redirect_to @city
  end

  def show
    @city = City.find(params[:id])
    redirect_to @city
  end
end
