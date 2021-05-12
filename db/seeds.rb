City.destroy_all
User.destroy_all

chantepie = City.create!(
  name: "Chantepie",
  description: "Chantepie est une commune française de Rennes Métropole située dans le département d'Ille-et-Vilaine, en région Bretagne. En 2018, avec 10 458 habitants, elle est la 10ᵉ commune la plus peuplée d’Ille-et-Vilaine et la 36ᵉ de Bretagne. Ses habitants sont appelés les Cantepiens et les Cantepiennes",
  population: 10445,
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
  latitude: 48.0867,
  longitude: -1.6161
  )

vézin_le_coquet = City.create!(
  name: "Vézin-le-Coquet",
  description: "Vezin-le-Coquet est une commune française située dans le département d'Ille-et-Vilaine, en région Bretagne. La ville appartient à l'agglomération de Rennes.",
  population: 5401,
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
  description: "Brest est une ville portuaire en Bretagne, au nord-ouest de la France. Elle est coupée en deux par la Penfeld. La ville est connue pour son riche passé maritime et sa base navale. À l'embouchure de la Penfeld, surplombant le port, se trouve le musée national de la Marine, qui occupe le château médiéval de Brest. De l'autre côté de la rivière se trouve la tour Tanguy, une tour médiévale. Au nord-est sont implantés le conservatoire botanique national et l'Océanopolis.",
  population: 139163,
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
