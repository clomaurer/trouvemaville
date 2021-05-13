class ChangeDefaultBooleanForCities < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:cities, :primary_school, false)
    change_column_default(:cities, :secondary_school, false)
    change_column_default(:cities, :doctor, false)
    change_column_default(:cities, :supermarket, false)
  end
end
