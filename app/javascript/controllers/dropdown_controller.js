import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    this.element.querySelector('#dropdown').classList.toggle('hidden');
  }
}
