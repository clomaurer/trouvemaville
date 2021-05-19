require 'csv'
require 'json'
require 'open-uri'

# FavoriteCity.destroy_all
# City.destroy_all
# User.destroy_all

# seeds generation upon CSV files

# Ouvrir le fichier population.csv
p "Population seeds incoming"
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/population.csv'

@geocode_population = []
@city_name_population = []

# Pour chaque ligne du fichier
@geocode_population = []
CSV.foreach(filepath, csv_options) do |row|
  # je prends le geocode
  geocode = row['geocode']
  @geocode_population << geocode
  commune = row['city_name']
  @city_name_population << commune.upcase

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



p "Network seeds incoming"
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
  city.update(name: row['city_name'], fibre: row['fibre_rate'])
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



p "Primary and secondary schools seeds incoming"
csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/ecoles.csv'


# Pour chaque ligne du fichier
CSV.foreach(filepath, csv_options) do |row|

  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))
  city = City.find_or_initialize_by(geocode: geocode)
  city.update(name: row['city_name'])

  primary_school = (row['code_nature'] == "151" || row['code_nature'] == "101")
  city.update(primary_school: true) if primary_school

  secondary_school = (row['code_nature'] == "340" ||
                      row['code_nature'] == "300" ||
                      row['code_nature'] == "320" ||
                      row['code_nature'] == "302" ||
                      row['code_nature'] == "306" ||
                      row['code_nature'] == "315" ||
                      row['code_nature'] == "334" ||
                      row['code_nature'] == "390")
  city.update(secondary_school: true) if secondary_school

  city.save!
end

p "Price market seeds incoming"
  cities = City.all
  cities.each do |city|
    if city.population <= 10000
      city.update(house_marketprice: 1600, flat_marketprice: 1400, land_marketprice: 50)
      city.save!
    elsif (city.population > 10000 && city.population <= 100000)
      city.update(house_marketprice: 2800, flat_marketprice: 2000, land_marketprice: 100)
      city.save!
    elsif city.population > 100000
      city.update(house_marketprice: 3500, flat_marketprice: 2200, land_marketprice: 150)
      city.save!
    end
  end


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



p "Primary and secondary schools seeds incoming"
csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/ecoles.csv'

CSV.foreach(filepath, csv_options) do |row|
  geocode = row['geocode']
  department_code = [22, 29, 35, 56]
  next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))
  city = City.find_or_initialize_by(geocode: geocode)
  city.update(name: row['city_name'])

  primary_school = (row['code_nature'] == "151" || row['code_nature'] == "101")
  city.update(primary_school: true) if primary_school

  secondary_school = (row['code_nature'] == "340" ||
                      row['code_nature'] == "300" ||
                      row['code_nature'] == "320" ||
                      row['code_nature'] == "302" ||
                      row['code_nature'] == "306" ||
                      row['code_nature'] == "315" ||
                      row['code_nature'] == "334" ||
                      row['code_nature'] == "390")
  city.update(secondary_school: true) if secondary_school

  city.save!
end

p "Market price seeds incoming"
  cities = City.all
  cities.each do |city|
    if city.population <= 10000
      city.update(house_marketprice: 1600, flat_marketprice: 1400, land_marketprice: 50)
      city.save!
    elsif (city.population > 10000 && city.population <= 100000)
      city.update(house_marketprice: 2800, flat_marketprice: 2000, land_marketprice: 100)
      city.save!
    elsif city.population > 100000
      city.update(house_marketprice: 3500, flat_marketprice: 2200, land_marketprice: 150)
      city.save!
    end
  end

p "Description and photos seeds incoming"
cities = City.all
cities.each do |city|
# p city.population
  url = URI.parse "https://fr.wikipedia.org/w/api.php?action=query&format=json&formatversion=2&redirects=true&prop=info%7Cextracts%7Cpageimages&exsentences=2&explaintext=true&piprop=thumbnail&pithumbsize=500&titles=#{URI.encode city.name}"
  city_serialized = URI.open(url).read
  city_infos = JSON.parse(city_serialized)
  if city_infos['query']['pages'][0]['extract'].nil?
    city.description = ""
  else
    city.description = city_infos['query']['pages'][0]['extract'].gsub(/\n+(==|===)\s\w.+/, "\n")
  end

  if city_infos['query']['pages'][0]['thumbnail'].nil?
    city.photo = ""
  else
   city.photo = city_infos['query']['pages'][0]['thumbnail']['source']
  end

  city.save!
end

