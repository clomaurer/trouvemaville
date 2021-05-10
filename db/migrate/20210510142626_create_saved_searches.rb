class CreateSavedSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :saved_searches do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :budget_max
      t.boolean :primary_school
      t.boolean :secondary_school
      t.integer :age_average
      t.boolean :supermarket
      t.boolean :network
      t.boolean :fibre
      t.boolean :commodity
      t.integer :min_surface
      t.integer :max_distance_km
      t.integer :max_distance_minutes
      t.string :property_type
      t.string :start_city
      t.boolean :doctor

      t.timestamps
    end
  end
end
