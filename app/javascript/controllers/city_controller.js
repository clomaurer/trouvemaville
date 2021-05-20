import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "marker"
  ]
  connect() {
  }

  favorite() {
    fetch(`/cities/${this.markerTarget.dataset.id}${this.markerTarget.dataset.query}`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        document.getElementById("show").innerHTML = data.city;
      });
  }

  show() {
    fetch(`/cities/${this.markerTarget.dataset.id}${window.location.search}`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        document.getElementById("show").innerHTML = data.city;
      });
  }

  close() {
    document.getElementById("show").innerHTML = "";
  }
}
