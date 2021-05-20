class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorites = current_user.favorite_cities.order(created_at: :desc).group_by { |city| city.saved_search }
  end

  def create
    @saved_search = SavedSearch.find_or_create_by(start_city: params[:location][:name],
                                                  primary_school: params[:primary_school].present?,
                                                  secondary_school: params[:secondary_school].present?,
                                                  supermarket: params[:supermarket].present?,
                                                  network: params[:network].present?,
                                                  fibre: params[:fibre].present?,
                                                  commodity: params[:commodity].present?,
                                                  doctor: params[:doctor].present?,
                                                  max_distance_km: params[:location][:max_distance_km].to_i,
                                                  age_average: params[:max_age_average].present? ? params[:max_age_average] : nil,
                                                  max_population: params[:max_population].present? ? params[:max_population] : nil)
    p @saved_search
    @city = City.find(params[:city_id])
    favorite = FavoriteCity.find_by(city: @city, user: current_user)
    if favorite.present?
      favorite.destroy
      render json: {
        result: "destroyed"
      }
    else
      @favorite = FavoriteCity.new
      @favorite.user = current_user
      @favorite.city = @city
      @favorite.saved_search = @saved_search
      @favorite.save!
      render json: {
        result: "created"
      }
    end
  end

  def show
    @city = City.find(params[:id])
    redirect_to favorites_path
  end
end
