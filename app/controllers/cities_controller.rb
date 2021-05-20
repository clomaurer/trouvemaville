class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  has_scope :max_population
  has_scope :max_age_average
  has_scope :location, using: %i[name max_distance_km], type: :hash

  def index
    @saved_search = SavedSearch.new
    @cities = apply_scopes(City).all

    @markers = @cities.map do |city|
      if rating(city) >= 75
        image_url = helpers.asset_url('green-marker.svg')
      elsif rating(city) >= 50
        image_url = helpers.asset_url('orange-marker.svg')
      elsif rating(city) < 50
        image_url = helpers.asset_url('red-marker.svg')
      end
      {
        lat: city.latitude,
        lng: city.longitude,
        id: city.id,
        image_url: image_url,
        infoWindow: render_to_string(partial: "info_window", locals: { city: city, doctor: params[:doctor],\
                                                                       network: params[:network],\
                                                                       fibre: params[:fibre],\
                                                                       commodity: params[:commodity],\
                                                                       supermarket: params[:supermarket],\
                                                                       primary_school: params[:primary_school],\
                                                                       secondary_school: params[:secondary_school],\
                                                                       max_population: params[:max_population],\
                                                                       age_average: params[:max_age_average],\
                                                                       rating: rating(city) })
      }
    end

    @city = params[:location][:name]
    @max_distance_km = params[:location][:max_distance_km]
    @max_population = params[:max_population]
    @max_age_average = params[:max_age_average]
  end

  def show
    @city = City.find(params[:id])
    @is_compared = ComparedCity.find_by(city: @city, comparator: current_user.comparator).present? if current_user
    @is_favorite = FavoriteCity.find_by(user: current_user, city: @city).present? if current_user
    @city_rating = rating(@city)

    #--------------------                    variables for thresholds                 ---------------------->
    @network_fibre_threshold = City::NETWORK_FIBRE_THRESHOLD #-- 4G rand fibre ate at 70% minimum (see model city.rb)
    @city_rating_middle_threshold = 75 #-- fibre rate at 75% minimum  -->
    @commodity_count_threshold = City::COMMODITY_COUNT_THRESHOLD #-- commodity count will be green if > 0 (see model city.rb)-->
    @city_rating_middle_threshold = 75  #-- city rating will be green above or equal to 75% -->
                                        #-- city rating will be orange above or equal to 50% and below 75% -->
    @city_rating_lower_threshold = 50   #-- city rating will be red below 50% -->

    respond_to do |format|
      format.html
      format.json {
        render json: {
          city: render_to_string(partial: "cities/city", layout: false, formats: [:html])
        }
      }
    end
  end

  private

  def rating(city)
    # pick-up all user criteria in url
    @doctor_presence = params[:doctor].present? && params[:doctor] == "1"
    @network_presence = params[:network].present? && params[:network] == "1"
    @fibre_presence = params[:fibre].present? && params[:fibre] == "1"
    @commodity_presence = params[:commodity].present? && params[:commodity] == "1"
    @supermarket_presence = params[:supermarket].present? && params[:supermarket] == "1"
    @primary_school_presence = params[:primary_school].present? && params[:primary_school] == "1"
    @secondary_school_presence = params[:secondary_school].present? && params[:secondary_school] == "1"
    @max_population_presence = params[:max_population].present? && params[:max_population].to_i >= 1
    @max_age_average_presence = params[:max_age_average].present? && params[:max_age_average].to_i >= 18

    # city global rating calculation
    @criteria_selected_nb = 0

    @criteria_selected_nb += 1 if @doctor_presence
    @criteria_selected_nb += 1 if @network_presence
    @criteria_selected_nb += 1 if @fibre_presence
    @criteria_selected_nb += 1 if @commodity_presence
    @criteria_selected_nb += 1 if @supermarket_presence
    @criteria_selected_nb += 1 if @primary_school_presence
    @criteria_selected_nb += 1 if @secondary_school_presence
    @criteria_selected_nb += 1 if @max_population_presence
    @criteria_selected_nb += 1 if @max_age_average_presence

    @match_criteria_nb = 0

    @match_criteria_nb += 1 if @doctor_presence && city.doctor
    @match_criteria_nb += 1 if @network_presence && city.network.to_f >= 70
    @match_criteria_nb += 1 if @fibre_presence && city.fibre.to_f >= 70
    @match_criteria_nb += 1 if @commodity_presence && city.commodity_count > 0
    @match_criteria_nb += 1 if @supermarket_presence && city.supermarket
    @match_criteria_nb += 1 if @primary_school_presence && city.primary_school
    @match_criteria_nb += 1 if @secondary_school_presence && city.secondary_school
    @match_criteria_nb += 1 if @max_population_presence && city.population <= params[:max_population].to_i
    @match_criteria_nb += 1 if @max_age_average_presence && city.age_average <= params[:max_age_average].to_i

    if @criteria_selected_nb > 0
      return ((@match_criteria_nb.to_f / @criteria_selected_nb) * 100).round
    else
      return 100
    end
  end
end
