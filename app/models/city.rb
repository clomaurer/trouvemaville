class City < ApplicationRecord
  geocoded_by :name
  has_many :favorite_cities
  has_one_attached :photo
  validates :name, presence: true
end
