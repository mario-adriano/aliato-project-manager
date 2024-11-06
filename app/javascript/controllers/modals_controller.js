import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };

  connect() {
    console.log("Modal controller connected");
    this.element.addEventListener("turbo:frame-load", () => {
      this.openModal();
    });
  }

  openModal(event) {
    const url = event.target.dataset.url;

    if (url) {
      history.pushState(null, "", url);
    }
  }

  close(e) {
    const url = e.currentTarget.getAttribute("data-url");
    e.preventDefault();
    const modal = document.getElementById("modal");
    modal.innerHTML = "";

    modal.removeAttribute("src");

    modal.removeAttribute("complete");

    if (url) {
      history.pushState(null, "", url);
    }
  }
}