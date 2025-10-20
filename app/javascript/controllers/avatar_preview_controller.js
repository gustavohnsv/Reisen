// Connects to data-controller="avatar-preview"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  preview(event) {
    const input = event.target
    const preview = document.getElementById("avatar-preview")
    const placeholder = document.getElementById("avatar-placeholder")
    if (!input.files || !input.files[0]) {
      if (preview) preview.style.display = "none"
      return
    }
    const file = input.files[0]
    if (!file.type.startsWith("image/")) {
      if (preview) preview.style.display = "none"
      return
    }

    const reader = new FileReader()
    reader.onload = (e) => {
      if (!preview) return
      preview.src = e.target.result
      preview.style.display = "block"
      placeholder.classList.add('d-none')    // ESCONDE o placeholder
      preview.classList.remove('d-none') // MOSTRA a imagem
    }
    reader.readAsDataURL(file)
  }
}