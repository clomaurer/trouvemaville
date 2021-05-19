class ComparedCity < ApplicationRecord
  belongs_to :city
  belongs_to :comparator
  validates :comparator, uniqueness: { scope: :city, message: "Pas deux fois la même ville" }

  validate :max_compared_cities

  def max_compared_cities
    errors.add(:base, "Pas plus de 4 villes") if comparator.compared_cities.count >= 4
  end
end
