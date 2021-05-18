class CreateComparedCities < ActiveRecord::Migration[6.0]
  def change
    create_table :compared_cities do |t|
      t.references :city, null: false, foreign_key: true
      t.references :comparator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
