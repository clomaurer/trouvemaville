class RemoveCommodityToSavedSearches < ActiveRecord::Migration[6.0]
  def change
    remove_column :saved_searches, :commodity
  end
end
