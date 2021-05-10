class CreateFavoriteCities < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_cities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
