import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
    static values = { content: String }

    copy() {
        navigator.clipboard.writeText(this.contentValue)
            .then(() => {
                console.log("Conteúdo copiado com sucesso!")
                this.addFeedback()
            })
            .catch(err => {
                console.error("Falha ao copiar o conteúdo: ", err)
            })
    }

    addFeedback() {
        const originalText = this.element.innerText
        this.element.innerText = "Copiado!"

        setTimeout(() => {
            this.element.innerText = originalText
        }, 2000)
    }
}
