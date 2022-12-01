import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="item-form"
export default class extends Controller {
  static targets = ["packagingWrapper", "packagingButton"]
  connect() {
    console.log("Hello from item form controller")
    console.log(this.element)
    console.log(this.packagingWrapperTarget)
    console.log(this.packagingButtonTarget)
  }

  addForm(e) {
    e.preventDefault()
    // console.dir(this.packagingWrapperTarget)
    this.packagingWrapperTarget.insertAdjacentHTML("beforeEnd", this.packagingWrapperTarget.innerHTML)
  }
}
