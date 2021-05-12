require 'csv'

City.destroy_all
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
p "Population seeds incoming"
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/population.csv'

@geocode_population = []

# Pour chaque ligne du fichier
@geocode_population = []
CSV.foreach(filepath, csv_options) do |row|
  # je prends le geocode
  geocode = row['geocode']
  @geocode_population << geocode

  department_code = [22, 29, 35, 56]

  # # je regarde s'il commence par 22, 29, 35, 56
  next unless department_code.include?(geocode[0..1].to_i)

  # Je retrouve la ville en DB avec le meme nom
  # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
  city = City.find_or_initialize_by(geocode: geocode)
  # je mets à jour ma ville en db avec la population du csv
  city.update(name: row['city_name'], population: row['population_2017'])
  # je sauve
  city.save!
end

p "Latitude & Longitude seeds incoming"
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath = 'db/fixtures/communes-coords-gps.csv'
CSV.foreach(filepath, csv_options) do |row|
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  next unless department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode)
  city = City.find_or_initialize_by(geocode: geocode)
  city.update(name: row['city_name'], latitude: row['latitude'], longitude: row['longitude'])
  city.save!
end

p "4G seeds incoming"
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath = 'db/fixtures/couverture-4G.csv'
CSV.foreach(filepath, csv_options) do |row|
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  next unless department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode)
  city = City.find_or_initialize_by(geocode: geocode)
  city.update(name: row['city_name'], network: row['4G_rate'])
  city.save!
end


p "Fibre seeds incoming"
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath = 'db/fixtures/couverture-fibre.csv'
CSV.foreach(filepath, csv_options) do |row|
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  next unless department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode)
  city = City.find_or_initialize_by(geocode: geocode)
  city.update(name: row['city_name'], fibre: row['fiber_rate'])
  city.save!
end
p "Medical services seeds incoming"
# Ouvrir le fichier service-medicaux.csv
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/service-medicaux.csv'

# Pour chaque ligne du fichier
CSV.foreach(filepath, csv_options) do |row|
  # je prends le geocode
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  # # je regarde s'il commence par 22, 29, 35, 56
  next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))

  # Je retrouve la ville en DB avec le meme nom
  # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
  city = City.find_or_initialize_by(geocode: geocode)
  # je mets à jour ma ville en db avec la population du csv
  doctor = false
  city_doctor = row['doctor'].to_i
  doctor = true if city_doctor > 0
  city.update(name: row['city_name'], doctor: doctor)
  # je sauve
  city.save!
end




p "Population average age seeds incoming"
# Ouvrir le fichier Age-moyen-population.csv
csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/Age-moyen-population.csv'

# Pour chaque ligne du fichier
CSV.foreach(filepath, csv_options) do |row|
  # je prends le geocode
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]

  # je regarde s'il commence par 22, 29, 35, 56
  next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))

  # Je retrouve la ville en DB avec le meme nom
  # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
  city = City.find_or_initialize_by(geocode: geocode)
  # je mets à jour ma ville en db avec la population du csv
  city.update(age_average: row['average_age_population'].to_i)
  # je sauve
  city.save!
end



p "Commodities seeds incoming"
# Ouvrir le fichier commerces.csv
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/commerces.csv'

# Pour chaque ligne du fichier
CSV.foreach(filepath, csv_options) do |row|
  # je prends le geocode
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  # # je regarde s'il commence par 22, 29, 35, 56

  next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))

  # Je retrouve la ville en DB avec le meme nom
  # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
  city = City.find_or_initialize_by(geocode: geocode)

  # je compte le nombre de commerces
  commodity_count = 0
  supermarket = false

  commodity_count = row['handiwork'].to_i + row['grocery'].to_i + row['bakery'].to_i\
                    + row['butchery'].to_i + row['frozen'].to_i + row['fish_market'].to_i\
                    + row['bookstore'].to_i + row['clothe'].to_i + row['appliance'].to_i\
                    + row['shoestore'].to_i + row['it'].to_i + row['furniture'].to_i\
                    + row['sport'].to_i + row['house'].to_i + row['hardware'].to_i\
                    + row['cosmetic'].to_i + row['jewellery'].to_i + row['plant'].to_i\
                    + row['optic'].to_i + row['medical_store'].to_i


  supermarket_count = row['supermarket'].to_i + row['hypermarket'].to_i + row['store'].to_i
  supermarket = true if supermarket_count > 0

  # je mets à jour ma ville en db avec la population du csv
  city.update(name: row['city_name'], commodity_count: commodity_count, supermarket: supermarket)
  # je sauve
  city.save!
end


