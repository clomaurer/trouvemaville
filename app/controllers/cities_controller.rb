class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @saved_search = SavedSearch.new
    @cities = City.near(params[:name], params[:max_distance_km].presence || 1)
    @markers = @cities.map do |city|
      {
        lat: city.latitude,
        lng: city.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { city: city, primary_school: params[:primary_school], secondary_school: params[:secondary_school] })
      }
    end

    @city = params[:name]
    @max_distance_km = params[:max_distance_km]
  end

  def show
    @city = City.find(params[:id])
    @is_favorite = FavoriteCity.find_by(user: current_user, city: @city).present? if current_user

    @primary_school_presence = params[:primary_school].present? && params[:primary_school] == "1"
    #@primary_school_criteria = @primary_school_presence && @city.primary_school

    @secondary_school_presence = params[:secondary_school].present? && params[:secondary_school] == "1"
    #@secondary_school_criteria = @secondary_school_presence && @city.secondary_school
  end
end
