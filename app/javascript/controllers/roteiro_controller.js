import { Controller } from "@hotwired/stimulus"

const DEFAULT_STORAGE_KEY = "reisen:roteiro:v1"
const DEFAULT_STATUS_MESSAGE = "Itens salvos localmente neste navegador."
const STATUS_TIMEOUT_MS = 2500

export default class extends Controller {
  static targets = [
    "form",
    "title",
    "description",
    "location",
    "date",
    "cost",
    "list",
    "emptyState",
    "status",
    "counter"
  ]

  static values = {
    storageKey: String
  }

  connect() {
    this.storageKey = this.hasStorageKeyValue ? this.storageKeyValue : DEFAULT_STORAGE_KEY
    this.state = { items: [], draft: {} }
    this.statusTimer = null
    this.storageAvailable = this.detectStorageAvailability()

    if (!this.storageAvailable) {
      this.disableForm()
      this.updateStatus("Não foi possível acessar o armazenamento local. Verifique as permissões do navegador.", "danger")
      return
    }

    this.state = this.loadState()
    this.applyDraft()
    this.render()
    this.updateStatus(DEFAULT_STATUS_MESSAGE)
  }

  disconnect() {
    if (this.statusTimer) {
      clearTimeout(this.statusTimer)
    }
  }

  addItem(event) {
    event.preventDefault()
    if (!this.storageAvailable) return

    const title = this.titleTarget.value.trim()
    if (!title) {
      this.titleTarget.focus()
      this.updateStatus("Informe um título para salvar o item.", "danger")
      return
    }

    const item = {
      id: Date.now(),
      title,
      description: this.descriptionTarget.value.trim(),
      location: this.locationTarget.value.trim(),
      date: this.dateTarget.value,
      cost: this.costTarget.value.trim()
    }

    this.state.items.push(item)
    this.state.draft = {}
    this.persistState()
    this.formTarget.reset()
    this.titleTarget.focus()
    this.applyDraft()
    this.render()
  }

  removeEntry(event) {
    if (!this.storageAvailable) return
    const { roteiroItemId } = event.currentTarget.dataset
    this.state.items = this.state.items.filter((item) => item.id.toString() !== roteiroItemId)
    this.persistState()
    this.render()
  }

  clearAll() {
    if (!this.storageAvailable) return
    if (!window.confirm("Remover todos os itens salvos localmente?")) return

    this.state = { items: [], draft: {} }
    try {
      window.localStorage.removeItem(this.storageKey)
    } catch (error) {
      console.warn("Não foi possível limpar o armazenamento local do roteiro.", error)
    }

    this.formTarget.reset()
    this.render()
    this.applyDraft()
    this.updateStatus("Roteiro limpo. Nenhum dado salvo no navegador.", "warning")
  }

  storeDraft() {
    if (!this.storageAvailable) return
    this.state.draft = this.readDraftFromInputs()
    this.persistState({ silent: true })
  }

  render() {
    if (!this.storageAvailable) return

    if (this.hasCounterTarget) {
      this.counterTarget.textContent = this.state.items.length
    }

    if (!this.hasListTarget || !this.hasEmptyStateTarget) return

    this.listTarget.innerHTML = ""

    if (this.state.items.length === 0) {
      this.emptyStateTarget.classList.remove("d-none")
      return
    }

    this.emptyStateTarget.classList.add("d-none")

    const sortedItems = this.state.items.slice().sort((a, b) => {
      const first = a.date || ""
      const second = b.date || ""
      if (first === second) return 0
      if (!first) return 1
      if (!second) return -1
      return first.localeCompare(second)
    })

    sortedItems.forEach((item) => {
      this.listTarget.appendChild(this.buildCardFor(item))
    })
  }

  buildCardFor(item) {
    const card = document.createElement("div")
    card.className = "card shadow-sm mb-3"

    const body = document.createElement("div")
    body.className = "card-body"
    card.appendChild(body)

    const header = document.createElement("div")
    header.className = "d-flex justify-content-between align-items-start"
    body.appendChild(header)

    const title = document.createElement("h3")
    title.className = "h6 mb-1"
    title.textContent = item.title
    header.appendChild(title)

    const removeButton = document.createElement("button")
    removeButton.type = "button"
    removeButton.className = "btn btn-sm btn-outline-danger"
    removeButton.dataset.action = "roteiro#removeEntry"
    removeButton.dataset.roteiroItemId = item.id
    removeButton.textContent = "Remover"
    header.appendChild(removeButton)

    if (item.description) {
      const description = document.createElement("p")
      description.className = "text-muted mb-2"
      description.textContent = item.description
      body.appendChild(description)
    }

    const details = document.createElement("dl")
    details.className = "row g-2 mb-0"

    if (item.location) {
      const dt = document.createElement("dt")
      dt.className = "col-sm-3 text-muted"
      dt.textContent = "Local"
      details.appendChild(dt)

      const dd = document.createElement("dd")
      dd.className = "col-sm-9 fw-semibold"
      dd.textContent = item.location
      details.appendChild(dd)
    }

    if (item.date) {
      const dt = document.createElement("dt")
      dt.className = "col-sm-3 text-muted"
      dt.textContent = "Quando"
      details.appendChild(dt)
    
      const dd = document.createElement("dd")
      dd.className = "col-sm-9 fw-semibold"
      dd.textContent = this.formatDate(item.date)
      details.appendChild(dd)
    }

    if (item.cost) {
      const dt = document.createElement("dt")
      dt.className = "col-sm-3 text-muted"
      dt.textContent = "Custo"
      details.appendChild(dt)

      const dd = document.createElement("dd")
      dd.className = "col-sm-9 fw-semibold"
      dd.textContent = this.formatCost(item.cost)
      details.appendChild(dd)
    }

    if (details.childElementCount > 0) {
      body.appendChild(details)
    }

    return card
  }

  detectStorageAvailability() {
    try {
      const testKey = "__roteiro_test__"
      window.localStorage.setItem(testKey, "1")
      window.localStorage.removeItem(testKey)
      return true
    } catch (error) {
      console.warn("LocalStorage indisponível.", error)
      return false
    }
  }

  loadState() {
    try {
      const raw = window.localStorage.getItem(this.storageKey)
      if (!raw) return { items: [], draft: {} }

      const parsed = JSON.parse(raw)
      if (Array.isArray(parsed)) {
        return { items: parsed, draft: {} }
      }

      const items = Array.isArray(parsed.items) ? parsed.items : []
      const draft = parsed.draft && typeof parsed.draft === "object" ? parsed.draft : {}
      return { items, draft }
    } catch (error) {
      console.warn("Não foi possível ler os dados locais do roteiro.", error)
      return { items: [], draft: {} }
    }
  }

  persistState({ silent = false } = {}) {
    try {
      const payload = JSON.stringify({ items: this.state.items, draft: this.state.draft })
      window.localStorage.setItem(this.storageKey, payload)
      if (!silent) {
        this.showTransientSuccess("Alterações salvas localmente.")
      }
    } catch (error) {
      console.error("Falha ao salvar o roteiro local.", error)
      this.updateStatus("Não foi possível salvar os dados localmente.", "danger")
    }
  }

  showTransientSuccess(message) {
    this.updateStatus(message, "positive")
    if (this.statusTimer) {
      clearTimeout(this.statusTimer)
    }
    this.statusTimer = window.setTimeout(() => {
      this.updateStatus(DEFAULT_STATUS_MESSAGE)
    }, STATUS_TIMEOUT_MS)
  }

  applyDraft() {
    const draft = this.state.draft || {}
    this.titleTarget.value = draft.title || ""
    this.descriptionTarget.value = draft.description || ""
    this.locationTarget.value = draft.location || ""
    this.dateTarget.value = draft.date || ""
    this.costTarget.value = draft.cost || ""
  }

  readDraftFromInputs() {
    return {
      title: this.titleTarget.value,
      description: this.descriptionTarget.value,
      location: this.locationTarget.value,
      date: this.dateTarget.value,
      cost: this.costTarget.value
    }
  }

  formatDate(value) {
    if (!value) return ""
    try {
      const date = new Date(value)
      if (Number.isNaN(date.getTime())) {
        return value
      }
      const options = { dateStyle: "medium" }
      // Check if the date has a time component by inspecting hours, minutes, or seconds
      if (date.getHours() !== 0 || date.getMinutes() !== 0 || date.getSeconds() !== 0) {
        options.timeStyle = "short"
      }
      return date.toLocaleString(undefined, options)
    } catch (error) {
      return value
    }
  }

  formatCost(value) {
    const numeric = parseFloat(value)
    if (Number.isNaN(numeric)) return value
    try {
      return new Intl.NumberFormat(undefined, { style: "currency", currency: "BRL" }).format(numeric)
    } catch (error) {
      return numeric.toFixed(2)
    }
  }

  updateStatus(message, variant = "muted") {
    if (!this.hasStatusTarget) return

    const baseClasses = ["small", "mt-3"]
    const variantClass = {
      muted: "text-muted",
      positive: "text-success",
      warning: "text-warning",
      danger: "text-danger"
    }[variant] || "text-muted"

    this.statusTarget.className = `${baseClasses.join(" ")} ${variantClass}`
    this.statusTarget.textContent = message
  }

  disableForm() {
    if (!this.hasFormTarget) return
    const elements = this.formTarget.querySelectorAll("input, textarea, button")
    elements.forEach((el) => {
      el.disabled = true
    })
  }
}
