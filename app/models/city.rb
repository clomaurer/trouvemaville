class City < ApplicationRecord
  geocoded_by :name
  has_many :favorite_cities
  validates :name, presence: true
end
