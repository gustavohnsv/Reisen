// app/javascript/controllers/tom_select_controller.js
import { Controller } from "@hotwired/stimulus"
import "tom-select"

export default class extends Controller {
    connect() {
        const create = this.element.dataset.tomSelectCreateValue === 'true'

        new window.TomSelect(this.element, {
            create: create,
            createOnBlur: true,
            placeholder: this.element.getAttribute('data-placeholder') || 'Selecione...',
            maxItems: 1
        })
    }
}