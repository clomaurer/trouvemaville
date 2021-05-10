class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.integer :population
      t.integer :commodity_count
      t.integer :house_marketprice
      t.boolean :primary_school
      t.boolean :secondary_school
      t.boolean :doctor
      t.integer :age_average
      t.boolean :supermarket
      t.integer :land_marketprice
      t.integer :flat_marketprice
      t.float :latitude
      t.float :longitude
      t.string :fibre
      t.string :network

      t.timestamps
    end
  end
end
