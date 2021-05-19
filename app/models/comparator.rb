class Comparator < ApplicationRecord
  belongs_to :user
  validates :user, uniqueness: true
  has_many :compared_cities
  has_many :cities, through: :compared_cities
  # validates_length_of :compared_cities, maximum: 4
end
