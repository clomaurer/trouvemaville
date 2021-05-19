class ComparedCitiesController < ApplicationController
  def create
    @city = City.find(params[:city_id])

    @compared_city = ComparedCity.find_by(comparator: current_user.comparator, city: @city)

    if @compared_city
      @compared_city.destroy
      render json: { status: "destroyed" }
    else
      @compared_city = ComparedCity.new(comparator: current_user.comparator, city: @city)
      if @compared_city.save
        render json: { status: "created" }
      else
        render json: { status: "failed", errors: @compared_city.errors.messages }
      end
    end
  end

  def destroy
    @compared_city = ComparedCity.find(params[:id])
    @compared_city.destroy
    redirect_to comparator_path
  end
end
