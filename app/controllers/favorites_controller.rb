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
      render json: {
        result: "Favorite destroyed"
      }
    else
      @favorite = FavoriteCity.new
      @favorite.user = current_user
      @favorite.city = @city
      @favorite.save
      render json: {
        result: "Favorite created"
      }
    end

  end

  def show
    @city = City.find(params[:id])
    redirect_to city_path(@city, params.permit!)
  end
end
