// app/javascript/controllers/tom_select_controller.js
import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
    connect() {
        new TomSelect(this.element, {
            allowEmptyOption: true,
            placeholder: this.element.getAttribute("placeholder") || 'Selecione...',
        })
    }
}