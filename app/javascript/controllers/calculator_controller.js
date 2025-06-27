import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calculator"
export default class extends Controller {
  static targets = [ "levelValue", "attackValue", "defenseValue", "staminaValue", "levelSlider", "attackSlider", "defenseSlider", "staminaSlider", "form" ]

  connect() {
    this.calculate()
  }

  updateLevelValue() {
    this.levelValueTarget.textContent = this.levelSliderTarget.value
    this.calculate()
  }

  updateAttackValue() {
    this.attackValueTarget.textContent = this.attackSliderTarget.value
    this.calculate()
  }

  updateDefenseValue() {
    this.defenseValueTarget.textContent = this.defenseSliderTarget.value
    this.calculate()
  }

  updateStaminaValue() {
    this.staminaValueTarget.textContent = this.staminaSliderTarget.value
    this.calculate()
  }

  calculate() {
    this.formTarget.requestSubmit()
  }
}
