import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {

  static targets = [ "star", "span" ]
  static values = { url: String }


  toggle() {
    this.starTarget.classList.toggle("far")
    this.starTarget.classList.toggle("fas")

    const marker = document.querySelector(`.marker[data-id="${this.starTarget.dataset.city}"]`)
    const imageUrlContainer = document.getElementById('star')
    const markerUrlContainer = document.getElementById('marker')

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken(),
        "Accept": "application/json",
        "Content-Type": "application/json"
      }
    }).then(reponse => reponse.json()).then(data => {
      if (data.result === "destroyed") {
        this.spanTarget.innerText = "Ajouter aux favoris"
        if (marker && markerUrlContainer) {
          marker.style.backgroundImage = `url(${markerUrlContainer.dataset.imageUrl})`
        }
      } else if (data.result === "created") {
        this.spanTarget.innerText = "Retirer des favoris"

        if (marker && imageUrlContainer) {
          marker.style.backgroundImage = `url(${imageUrlContainer.dataset.imageUrl})`
        }
      }
    })

  }
}

