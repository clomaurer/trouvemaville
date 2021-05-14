class AddCommodityToSavedSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :saved_searches, :commodity, :boolean
  end
end
