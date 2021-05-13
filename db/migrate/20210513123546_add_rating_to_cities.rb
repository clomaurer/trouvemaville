class AddRatingToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :rating, :integer, default: 0, null: false
  end
end
