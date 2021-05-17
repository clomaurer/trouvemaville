class City < ApplicationRecord
  geocoded_by :name
  has_many :favorite_cities
  has_one_attached :photo
  validates :name, presence: true
  scope :max_population, -> max_population { where("population < ?", max_population) }
  scope :max_age_average, -> max_age { where("age_average < ?", max_age) }
  scope :location, -> name, max_distance_km { near(name, max_distance_km) }
end
