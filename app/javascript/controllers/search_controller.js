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
    "maxDistanceKm"
  ]
  connect() {
  }

  navigate() {
    const supermarket = `supermarket=${this.supermarketTarget.value ? "1" : "0" }`
    const city = `name=${this.startCityTarget.value}`
    const maxDisKm = `max_distance_km=${this.maxDistanceKmTarget.value}`
    const com = `commodity=${this.commodityTarget.value ? "1" : "0" }`
    const primary = `primary_school=${this.primarySchoolTarget.value ? "1" : "0" }`
    const secondary = `secondary_school=${this.secondarySchoolTarget.value ? "1" : "0" }`
    const fibre = `fibre=${this.fibreTarget.value ? "1" : "0" }`
    const network = `network=${this.networkTarget.value ? "1" : "0" }`
    const doctor = `docto=${this.doctorTarget.value ? "1" : "0" }`
    const url = `/cities?${city}&${maxDisKm}&${com}&${primary}&${secondary}&${network}`
    window.location = url
  }
}
