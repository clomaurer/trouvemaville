class City < ApplicationRecord
  has_many :favorite_cities
  has_one_attached :photo
end
