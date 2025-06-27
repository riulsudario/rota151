import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="iv-calculator"
export default class extends Controller {
  static targets = [
    "levelSlider", "levelValue",
    "attackSlider", "attackValue", "attackUnknown",
    "defenseSlider", "defenseValue", "defenseUnknown",
    "staminaSlider", "staminaValue", "staminaUnknown"
  ]

  connect() {
    this.updateLevel()
    this.updateAttack()
    this.updateDefense()
    this.updateStamina()

    this.toggleAttack()
    this.toggleDefense()
    this.toggleStamina()
  }

  // Update functions for sliders
  updateLevel() { this.levelValueTarget.textContent = this.levelSliderTarget.value }
  updateAttack() { this.attackValueTarget.textContent = this.attackSliderTarget.value }
  updateDefense() { this.defenseValueTarget.textContent = this.defenseSliderTarget.value }
  updateStamina() { this.staminaValueTarget.textContent = this.staminaSliderTarget.value }

  // Toggle functions for checkboxes
  toggleAttack() { this.attackSliderTarget.disabled = this.attackUnknownTarget.checked }
  toggleDefense() { this.defenseSliderTarget.disabled = this.defenseUnknownTarget.checked }
  toggleStamina() { this.staminaSliderTarget.disabled = this.staminaUnknownTarget.checked }
}
