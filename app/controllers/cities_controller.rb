class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @saved_search = SavedSearch.new
    @cities = City.near(params[:name], params[:max_distance_km].presence || 1)
    @markers = @cities.map do |city|
      {
        lat: city.latitude,
        lng: city.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { city: city })
      }
    end

    @city = params[:name]
    @max_distance_km = params[:max_distance_km]
  end

  def show
    @city = City.find(params[:id])
    @is_favorite = FavoriteCity.find_by(user: current_user, city: @city).present? if current_user
  end
end
