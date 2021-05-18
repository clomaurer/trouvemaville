class ComparedCitiesController < ApplicationController
  def create
    @city = City.find(params[:city_id])
    @compared_city = ComparedCity.new
    @compared_city.comparator = current_user.comparator
    @compared_city.city = @city
    @compared_city.save
    # if @compared_city.save
    #   render json: { success: true }
    # else
    #   render json: { success: false, errors: @compared_city.errors.messages }
    # end
  end

  def destroy
    @compared_city = ComparedCity.find(params[:id])
    @compared_city.destroy
    redirect_to comparator_path
  end
end
