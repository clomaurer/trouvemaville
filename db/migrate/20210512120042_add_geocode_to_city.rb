class AddGeocodeToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :geocode, :integer
  end
end
