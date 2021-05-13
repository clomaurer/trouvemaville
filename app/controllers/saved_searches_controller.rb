class SavedSearchesController < ApplicationController
  def index
    @searches = SavedSearch.all
  end

  def create
    @search = SavedSearch.new(saved_search_params)
    @search.user = current_user
    @search.save
  end

  def destroy
    @search = SavedSearch.find(params[:id])
    @search.destroy
    redirect_to saved_searches_path
  end

  private

  def saved_search_params
    params.require(:saved_search).permit(:max_distance_km, :start_city)
  end
end
