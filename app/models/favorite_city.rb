class FavoriteCity < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :saved_search
end
