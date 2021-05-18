class SavedSearchesController < ApplicationController
  def destroy
    @search = SavedSearch.find(params[:id])
    @search.destroy
    redirect_to favorites_path
  end
end
