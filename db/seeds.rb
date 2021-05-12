require 'csv'

# City.destroy_all

# User.destroy_all

# rennes = City.create!(
#   name: "Rennes",
#   description: "Rennes est la préfecture de la région Bretagne, au nord-ouest de la France. Elle est connue pour ses maisons médiévales à colombages et son immense cathédrale. Le parc du Thabor dispose d'une roseraie et d'une volière. Au sud de la Vilaine, le musée des Beaux-Arts expose des œuvres de Boticelli, Rubens et Picasso. Le centre culturel des Champs Libres abrite le musée de Bretagne et l'espace des Sciences, doté d'un planétarium.",
#   population: 217728,
#   commodity_count: 25,
#   house_marketprice: 4223,
#   primary_school: true,
#   secondary_school: true,
#   doctor: true,
#   age_average: 38,
#   supermarket: true,
#   flat_marketprice: 3400,
#   fibre: "85%",
#   network: "100%",
#   latitude: 48.117266,
#   longitude: -1.6777926,
#   )

# brest = City.create!(
#   name: "Brest",
#   description: "Rennes est la préfecture de la région Bretagne, au nord-ouest de la France. Elle est connue pour ses maisons médiévales à colombages et son immense cathédrale. Le parc du Thabor dispose d'une roseraie et d'une volière. Au sud de la Vilaine, le musée des Beaux-Arts expose des œuvres de Boticelli, Rubens et Picasso. Le centre culturel des Champs Libres abrite le musée de Bretagne et l'espace des Sciences, doté d'un planétarium.",
#   population: 217728,
#   commodity_count: 25,
#   house_marketprice: 4223,
#   primary_school: true,
#   secondary_school: true,
#   doctor: true,
#   age_average: 38,
#   supermarket: true,
#   flat_marketprice: 3400,
#   fibre: "85%",
#   network: "100%",
#   latitude: 48.3897,
#   longitude: -4.48333,

#   )

# user = User.create!(
#   email: "user@example.fr",
#   password: "12345678",
#   )



# # seeds generation upon CSV files

# Ouvrir le fichier population.csv
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/population.csv'

# Pour chaque ligne du fichier
CSV.foreach(filepath, csv_options) do |row|
  # je prends le geocode
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]

  # # je regarde s'il commence par 22, 29, 35, 56
  next unless department_code.include?(geocode[0..1])

  # Je retrouve la ville en DB avec le meme nom
  # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
  city = City.find_or_initialize_by(geocode: geocode)
  # je mets à jour ma ville en db avec la population du csv
  city.update(name: row['city_name'], population: row['population_2017'])
  # je sauve
  city.save!
end





# selectionner toutes les villes dont le geocode commence par 22, 29, 35 et 56
# Créer ces villes et leur attribuer la population (selectionner les bonnes colonnes)


# Ouvrir le fichier commerces.csv
# Mettre à jour les villes existantes avec les data recherchées (selectionner les bonnes colonnes)
# Ajouter les villes si elles n existent pas

# Ouvrir le fichier medical.csv
# Mettre à jour les villes existantes avec les data recherchées (selectionner les bonnes colonnes)
# Ajouter les villes si elles n existent pas

# etc...







