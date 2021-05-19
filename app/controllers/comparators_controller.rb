class ComparatorsController < ApplicationController
  def show
    comparator = Comparator.find_or_create_by(user: current_user)
    @compared_cities = comparator.compared_cities
  end
end
