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


# p "Latitude & Longitude seeds incoming"
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# filepath = 'db/fixtures/communes-coords-gps.csv'
# CSV.foreach(filepath, csv_options) do |row|
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]
#   next unless department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode)
#   city = City.find_or_initialize_by(geocode: geocode)
#   city.update(name: row['city_name'], latitude: row['latitude'], longitude: row['longitude'])
#   city.save!
# end


# p "Network seeds incoming"
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# filepath = 'db/fixtures/couverture-4G.csv'
# CSV.foreach(filepath, csv_options) do |row|
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]
#   next unless department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode)
#   city = City.find_or_initialize_by(geocode: geocode)
#   city.update(name: row['city_name'], network: row['4G_rate'])
#   city.save!
# end


# p "Fibre seeds incoming"
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# filepath = 'db/fixtures/couverture-fibre.csv'
# CSV.foreach(filepath, csv_options) do |row|
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]
#   next unless department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode)
#   city = City.find_or_initialize_by(geocode: geocode)
#   city.update(name: row['city_name'], fibre: row['fibre_rate'])
#   city.save!
# end


# p "Medical services seeds incoming"
# # Ouvrir le fichier service-medicaux.csv
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# filepath    = 'db/fixtures/service-medicaux.csv'

# # Pour chaque ligne du fichier
# CSV.foreach(filepath, csv_options) do |row|
#   # je prends le geocode
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]
#   # # je regarde s'il commence par 22, 29, 35, 56
#   next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))

#   # Je retrouve la ville en DB avec le meme nom
#   # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
#   city = City.find_or_initialize_by(geocode: geocode)
#   # je mets à jour ma ville en db avec la population du csv
#   doctor = false
#   city_doctor = row['doctor'].to_i
#   doctor = true if city_doctor > 0
#   city.update(name: row['city_name'], doctor: doctor)
#   # je sauve
#   city.save!
# end




# p "Population average age seeds incoming"
# # Ouvrir le fichier Age-moyen-population.csv
# csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
# filepath    = 'db/fixtures/Age-moyen-population.csv'

# # Pour chaque ligne du fichier
# CSV.foreach(filepath, csv_options) do |row|
#   # je prends le geocode
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]

#   # je regarde s'il commence par 22, 29, 35, 56
#   next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))

#   # Je retrouve la ville en DB avec le meme nom
#   # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
#   city = City.find_or_initialize_by(geocode: geocode)
#   # je mets à jour ma ville en db avec la population du csv
#   city.update(age_average: row['average_age_population'].to_i)
#   # je sauve
#   city.save!
# end



# p "Commodities seeds incoming"
# # Ouvrir le fichier commerces.csv
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# filepath    = 'db/fixtures/commerces.csv'

# # Pour chaque ligne du fichier
# CSV.foreach(filepath, csv_options) do |row|
#   # je prends le geocode
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]
#   # # je regarde s'il commence par 22, 29, 35, 56

#   next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))

#   # Je retrouve la ville en DB avec le meme nom
#   # Si il n'y en a pas, je crée une nouvelle ville avec ce nom
#   city = City.find_or_initialize_by(geocode: geocode)

#   # je compte le nombre de commerces
#   commodity_count = 0
#   supermarket = false

#   commodity_count = row['handiwork'].to_i + row['grocery'].to_i + row['bakery'].to_i\
#                     + row['butchery'].to_i + row['frozen'].to_i + row['fish_market'].to_i\
#                     + row['bookstore'].to_i + row['clothe'].to_i + row['appliance'].to_i\
#                     + row['shoestore'].to_i + row['it'].to_i + row['furniture'].to_i\
#                     + row['sport'].to_i + row['house'].to_i + row['hardware'].to_i\
#                     + row['cosmetic'].to_i + row['jewellery'].to_i + row['plant'].to_i\
#                     + row['optic'].to_i + row['medical_store'].to_i


#   supermarket_count = row['supermarket'].to_i + row['hypermarket'].to_i + row['store'].to_i
#   supermarket = true if supermarket_count > 0

#   # je mets à jour ma ville en db avec la population du csv
#   city.update(name: row['city_name'], commodity_count: commodity_count, supermarket: supermarket)
#   # je sauve
#   city.save!
# end



# p "Primary and secondary schools seeds incoming"
# csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
# filepath    = 'db/fixtures/ecoles.csv'

# CSV.foreach(filepath, csv_options) do |row|
#   geocode = row['geocode']
#   department_code = [22, 29, 35, 56]
#   next unless (department_code.include?(geocode[0..1].to_i) && @geocode_population.include?(geocode))
#   city = City.find_or_initialize_by(geocode: geocode)
#   city.update(name: row['city_name'])

#   primary_school = (row['code_nature'] == "151" || row['code_nature'] == "101")
#   city.update(primary_school: true) if primary_school

#   secondary_school = (row['code_nature'] == "340" ||
#                       row['code_nature'] == "300" ||
#                       row['code_nature'] == "320" ||
#                       row['code_nature'] == "302" ||
#                       row['code_nature'] == "306" ||
#                       row['code_nature'] == "315" ||
#                       row['code_nature'] == "334" ||
#                       row['code_nature'] == "390")
#   city.update(secondary_school: true) if secondary_school

#   city.save!
# end



# p "Description and photos seeds incoming"
# cities = City.all
# cities.each do |city|
# # p city.population
#   url = URI.parse "https://fr.wikipedia.org/w/api.php?action=query&format=json&formatversion=2&redirects=true&prop=info%7Cextracts%7Cpageimages&exsentences=2&explaintext=true&piprop=thumbnail&pithumbsize=500&titles=#{URI.encode city.name}"
#   city_serialized = URI.open(url).read
#   city_infos = JSON.parse(city_serialized)
#   if city_infos['query']['pages'][0]['extract'].nil?
#     city.description = ""
#   else
#     city.description = city_infos['query']['pages'][0]['extract'].gsub(/\n+(==|===)\s\w.+/, "\n")
#   end

#   if city_infos['query']['pages'][0]['thumbnail'].nil?
#     city.photo = ""
#   else
#    city.photo = city_infos['query']['pages'][0]['thumbnail']['source']
#   end

#   city.save!

# end


# prices market seeds
def average_per_department
  # calcul de la moyenne par departement
  cities_grouped_array = @sold_objects.group_by {|dpt| dpt["city_department"]}.values

  cities_grouped_array.each do |city_array_of_hashes|

    m2_price = 0
    m2_price_sum = 0
    @department_m2_price = 0
    to_ignore = 0

    city_array_of_hashes.each do |city_hash|
        @dpt = city_hash["city_department"]
        # p "Dpt : #{@dpt}"

        # je prends la valeur price
        price = city_hash["price"]
        # p "prix : #{price}"
        # je prends la valeur surface
        surface = city_hash["surface"]
        # p "Surface : #{surface}"

        # Je calcul le prix du m2
        if (!surface.nil? && surface.to_f != 0)
          if (!price.nil? && price.to_i >= 10000 && price.to_i < 1500000)
            m2_price = (price.to_f / surface.to_i).round
          else
            m2_price = 0
            to_ignore += 1
          end
          # p "prix m2: #{m2_price}"
        else
          m2_price = 0
          to_ignore += 1
        end
        # j'ajoute à une somme
        m2_price_sum += m2_price
    end

    # je divise la somme par le nb de hash
    if city_array_of_hashes.count != 0
      @department_m2_price = (m2_price_sum / (city_array_of_hashes.count - to_ignore)).round
    else
      @department_m2_price = 0
    end
    p "Market price in #{@dpt} dpt: #{@department_m2_price}€/m2"
  end
end


def average_per_city
  # calcul de la moyenne par ville
  cities_grouped_array = @sold_objects.group_by {|city| city["city_name"]}.values

  cities_grouped_array.each do |city_array_of_hashes|

    m2_price = 0
    m2_price_sum = 0
    @city_m2_price = 0
    to_ignore = 0

    city_array_of_hashes.each do |city_hash|
        @city = city_hash["city_name"]

        #je prends la valeur price
        price = city_hash["price"]
        #je prends la valeur surface
        surface = city_hash["surface"]
        #je prends le type de bien vendu
        @sell_type = city_hash["sell_type"]
        #Je calcul le prix du m2

        if (!surface.nil? && surface.to_f != 0)
          if (!price.nil? && price.to_i >= 10000 && price.to_i < 1500000)
            m2_price = (price.to_f / surface.to_i).round
          else
            m2_price = 0
            to_ignore += 1
          end
          # p "prix m2: #{m2_price}"
        else
          m2_price = 0
          to_ignore += 1
        end
        # j'ajoute à une somme
        m2_price_sum += m2_price
    end

    #je divise la somme par le nb de hash
    if (city_array_of_hashes.count >= 1 && m2_price_sum != 0)
      @city_m2_price = (m2_price_sum / (city_array_of_hashes.count - to_ignore)).round
    else
      @city_m2_price = @department_m2_price
    end
    p "#{@sell_type} market price in #{@city} city: #{@city_m2_price}€/m2"



    # downcase all cities names in db
    cities = City.all
    cities.each do | city |
      city.name.downcase
    end

    if @sell_type == "Maison"
      @city_to_update = City.where(name: @city.downcase)
      p "city to update : #{@city_to_update}"
      p "prix m2: #{@city_m2_price}"

      @city_to_update.update(house_marketprice: @city_m2_price)
      @city_to_update.save!
      p "#{@@city_to_update} updated"

    # elsif sell_type == "Appartement"
    #   @city_to_update = City.where("name" => @city.capitalize)
    #   @city_to_update.update(flat_marketprice: @city_m2_price)
    #   @city_to_update.save!

    # elsif sell_type == "Vente terrain a batir"
    #   @city_to_update = City.where("name" => @city.capitalize)
    #   @city_to_update.update(land_marketprice: @city_m2_price)
    #   @city_to_update.save!


    # Balayer les villes des seeds "population" qui n'ont pas été vues par la seed des prices market
    # et mettre le prix du departement

    end
  end
end


p "Price market seeds incoming"
csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = 'db/fixtures/valeurs_foncieres_Bretagne_2020.csv'

# cities =[]

@cities_houses = []
@cities_apartments = []
@cities_lands = []

CSV.foreach(filepath, csv_options) do |row|
  file_dpt_code = row['Code departement']
  file_city_name = row['Commune']

  department_code = [22, 29, 35, 56]
  if (department_code.include?(file_dpt_code.to_i) && @city_name_population.include?(file_city_name))
    if row["No_disposition"] == "1"

      # construction de l'array de hashs pour les apartements
      # if row['Type_local'] == "Appartement"
      #   if row['Nature_mutation'] == "Vente" || row['Nature_mutation'] == "Vente en l'etat futur d'achevement"
      #       apartment = Hash.new
      #       apartment["city_department"] = file_dpt_code
      #       apartment["city_name"] = file_city_name
      #       apartment["surface"] = row['Surface_reelle_bati']
      #       apartment["price"] = row['Valeur_fonciere']
      #       apartment["sell_type"] = row['Type_local']
      #       @cities_apartments << apartment
      #   end
      # end

      # construction de l'array de hashs pour les maisons
      if row["Type_local"] == "Maison"
        if row["Nature_mutation"] == "Vente" || row["Nature_mutation"] == "Vente en l'etat futur d'achevement"
            house = Hash.new
            house["city_department"] = file_dpt_code
            house["city_name"] = file_city_name
            house["surface"] = row['Surface_reelle_bati']
            house["price"] = row['Valeur_fonciere']
            house["sell_type"] = row['Type_local']
            @cities_houses << house
        end
      end

      # construction de l'array de hashs pour les terrains
      # @type_of_nature_mutation = row['Nature_mutation']
      # if row['Nature_mutation'] == "Vente terrain a batir"
      #     if row['Nature culture'] = "AB"
      #       land = Hash.new
      #       land["city_department"] = file_dpt_code
      #       land["city_name"] = file_city_name
      #       land["surface"] = row['Surface_terrain']
      #       land["price"] = row['Valeur_fonciere']
      #       land["sell_type"] = row['Nature_mutation']
      #       @cities_lands << land
      #     end
      # end
    end
  end
end

@sold_objects = @cities_houses
p "      Houses market price per department calculation..."
average_per_department
p "      Houses market price per city calculation..."
average_per_city

# @sold_objects = @cities_apartments
# p "      Apartments market price per department calculation..."
# average_per_department
# p "      Apartments market price per city calculation..."
# average_per_city

# @sold_objects = @cities_lands
# p "      Lands market price per department calculation..."
# average_per_department
# p "      Lands market price per city calculation..."
# average_per_city






# p "Fake price market seeds incoming"
#   cities = City.all
#   cities.each do |city|
#     if city.population <= 10000
#       city.update(house_marketprice: 1600, flat_marketprice: 1400, land_marketprice: 50)
#       city.save!
#     elsif (city.population > 10000 && city.population <= 100000)
#       city.update(house_marketprice: 2800, flat_marketprice: 2000, land_marketprice: 100)
#       city.save!
#     elsif city.population > 100000
#       city.update(house_marketprice: 3500, flat_marketprice: 2200, land_marketprice: 150)
#       city.save!
#     end
#   end



