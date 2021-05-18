class AddMaxPopulationToSavedSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :saved_searches, :max_population, :integer
  end
end
