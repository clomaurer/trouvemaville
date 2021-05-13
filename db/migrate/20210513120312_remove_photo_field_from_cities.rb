class RemovePhotoFieldFromCities < ActiveRecord::Migration[6.0]
  def change
    remove_column :cities, :photo
  end
end
