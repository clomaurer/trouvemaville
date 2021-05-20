import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "startCity",
    "supermarket",
    "commodity",
    "primarySchool",
    "secondarySchool",
    "fibre",
    "network",
    "doctor",
    "maxDistanceKm",
    "maxPopulation",
    "maxAgeAverage",
    "favorites"
  ]
  connect() {
    const query = this.buildQuery()
    this.favoritesTarget.dataset.query = query
  }

  navigate() {
    const query = this.buildQuery()
    const url = `/cities${query}`
    window.location = url
  }

  buildQuery() {
    const supermarket = this.supermarketTarget.checked ? 'supermarket=1' : ''

    const city = `location[name]=${this.startCityTarget.value}`

    const maxDisKm = `location[max_distance_km]=${this.maxDistanceKmTarget.value}`

    const com = this.commodityTarget.checked ? 'commodity=1' : ''

    const primary = this.primarySchoolTarget.checked ? 'primary_school=1' : ''

    const secondary = this.secondarySchoolTarget.checked ? 'secondary_school=1' : ''

    const fibre = this.fibreTarget.checked ? 'fibre=1' : ''

    const network = this.networkTarget.checked ? 'network=1' : ''

    const doctor = this.doctorTarget.checked ? 'doctor=1' : ''

    const max_population = this.maxPopulationTarget.value === undefined ? '' : `max_population=${this.maxPopulationTarget.value}`

    const max_age_average = this.maxAgeAverageTarget.value === undefined ? '' : `max_age_average=${this.maxAgeAverageTarget.value}`

    const query = `?${city}&${maxDisKm}&${com}&${primary}&${secondary}&${fibre}&${network}&${doctor}&${supermarket}&${max_population}&${max_age_average}`
    return query
  }
}
