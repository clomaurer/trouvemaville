class AddPhotoToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :photo, :string
  end
end
