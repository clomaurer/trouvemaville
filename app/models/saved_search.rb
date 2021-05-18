class SavedSearch < ApplicationRecord
  has_many :favorite_cities, dependent: :destroy
end
