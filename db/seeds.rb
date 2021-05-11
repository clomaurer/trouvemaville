City.destroy_all
User.destroy_all

chantepie = City.create!(
  name: "Chantepie",
  latitude: 48.0867,
  longitude: -1.6161
  )

vézin_le_coquet = City.create!(
  name: "Vézin-le-Coquet",
  latitude: 48.118,
  longitude: -1.756
  )

rennes = City.create!(
  name: "Rennes",
  description: "Rennes est la préfecture de la région Bretagne, au nord-ouest de la France. Elle est connue pour ses maisons médiévales à colombages et son immense cathédrale. Le parc du Thabor dispose d'une roseraie et d'une volière. Au sud de la Vilaine, le musée des Beaux-Arts expose des œuvres de Boticelli, Rubens et Picasso. Le centre culturel des Champs Libres abrite le musée de Bretagne et l'espace des Sciences, doté d'un planétarium.",
  population: 217728,
  commodity_count: 25,
  house_marketprice: 4223,
  primary_school: true,
  secondary_school: true,
  doctor: true,
  age_average: 38,
  supermarket: true,
  flat_marketprice: 3400,
  fibre: "85%",
  network: "100%",
  latitude: 48.117266,
  longitude: -1.6777926,
  )

brest = City.create!(
  name: "Brest",
  description: "Rennes est la préfecture de la région Bretagne, au nord-ouest de la France. Elle est connue pour ses maisons médiévales à colombages et son immense cathédrale. Le parc du Thabor dispose d'une roseraie et d'une volière. Au sud de la Vilaine, le musée des Beaux-Arts expose des œuvres de Boticelli, Rubens et Picasso. Le centre culturel des Champs Libres abrite le musée de Bretagne et l'espace des Sciences, doté d'un planétarium.",
  population: 217728,
  commodity_count: 25,
  house_marketprice: 4223,
  primary_school: true,
  secondary_school: true,
  doctor: true,
  age_average: 38,
  supermarket: true,
  flat_marketprice: 3400,
  fibre: "85%",
  network: "100%",
  latitude: 48.3897,
  longitude: -4.48333,

  )

user = User.create!(
  email: "user@example.fr",
  password: "12345678",
  )
