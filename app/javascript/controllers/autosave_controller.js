import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autosave"
export default class extends Controller {
  save() {
        console.log("Campo alterado com sucesso apos perder o foco")
        this.element.requestSubmit()
        // location.reload()
  }
}
