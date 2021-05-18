class AddSavedSearchIdToFavoriteCities < ActiveRecord::Migration[6.0]
  def change
    add_reference :favorite_cities, :saved_search, null: false, foreign_key: true
  end
end
