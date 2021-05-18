class AddDefaultsToFieldsInSavedSearches < ActiveRecord::Migration[6.0]
  def change
    change_column :saved_searches, :primary_school, :boolean, default: false
    change_column :saved_searches, :secondary_school, :boolean, default: false
    change_column :saved_searches, :supermarket, :boolean, default: false
    change_column :saved_searches, :network, :boolean, default: false
    change_column :saved_searches, :fibre, :boolean, default: false
    change_column :saved_searches, :doctor, :boolean, default: false
    change_column :saved_searches, :commodity, :boolean, default: false
  end
end
