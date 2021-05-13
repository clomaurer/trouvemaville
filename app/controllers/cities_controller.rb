class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @saved_search = SavedSearch.new
    @cities = City.near(params[:name], params[:max_distance_km].presence || 1)
    @markers = @cities.map do |city|
      {
        lat: city.latitude,
        lng: city.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { city: city, doctor: params[:doctor],\
                                                                       network: params[:network],\
                                                                       fibre: params[:fibre],\
                                                                       commodity: params[:commodity],\
                                                                       supermarket: params[:supermarket] })
      }
    end

    @city = params[:name]
    @max_distance_km = params[:max_distance_km]
  end

  def show
    @city = City.find(params[:id])
    @is_favorite = FavoriteCity.find_by(user: current_user, city: @city).present? if current_user

    @criteria_selected = []

    # pick-up doctor criteria in url
    @doctor_presence = params[:doctor].present? && params[:doctor] == "1"
    @criteria_selected << 1 if @doctor_presence

    # pick-up network criteria in url
    @network_presence = params[:network].present? && params[:network] == "1"
    @criteria_selected << 1 if @network_presence

    # pick-up fibre criteria in url
    @fibre_presence = params[:fibre].present? && params[:fibre] == "1"
    @criteria_selected << 1 if @fibre_presence

    # pick-up commodity criteria in url
    @commodity_presence = params[:commodity].present? && params[:commodity] == "1"
    @criteria_selected << 1 if @commodity_presence

    # pick-up supermarket criteria in url
    @supermarket_presence = params[:supermarket].present? && params[:supermarket] == "1"
    @criteria_selected << 1 if @supermarket_presence

    # city global rating calculation

    @match_criteria_nb = 0

    @match_criteria_nb += 1 if @doctor_presence && @city.doctor
    @match_criteria_nb += 1 if @network_presence && @city.network.to_i > 70
    @match_criteria_nb += 1 if @fibre_presence && @city.fibre.to_i > 70
    @match_criteria_nb += 1 if @commodity_presence && @city.commodity_count > 0
    @match_criteria_nb += 1 if @supermarket_presence && @city.supermarket

    @city_rating = ((@match_criteria_nb.to_f / @criteria_selected.count.to_f) * 100).round

    @city.update(rating: @city_rating)

    #--------------------                    variables for thresholds                 ---------------------->
    @network_fibre_threshold = 70       #-- 4G rate at 70% minimum
    @city_rating_middle_threshold = 75  #-- fibre rate at 75% minimum  -->
    @commodity_count_threshold = 0      #-- fibre rate at 0 minimum  -->
    @city_rating_middle_threshold = 75  #-- city rating will be green above or equal to 75% -->
                                       #-- city rating will be orange above or equal to 50% and below 75% -->
    @city_rating_lower_threshold = 50   #-- city rating will be red below 50% -->


  end
end
