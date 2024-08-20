import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import { put } from "@rails/request.js";

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 400,
      ghostClass: "bg-gray-200",
      onEnd: this.onEnd.bind(this),
      handle: "[data-sortable-handle]",
    });
  }

  disconnect() {
    this.sortable.destroy();
  }

  onEnd(event) {
    const { newIndex, item } = event;
    const url = item.dataset["sortableUrl"];
    const phaseId = parseInt(item.dataset.phaseId);
    const isEnd = newIndex === 0;

    put(url, {
      body: JSON.stringify({ position: newIndex, isEnd })
    }).then(() => {
      if (isEnd) {
        this.updateFinalPhaseButton(phaseId);
      }
    });
  }

  updateFinalPhaseButton(phaseId) {
    const turboFrameId = "refresh_button_"+phaseId;
    const turboFrame = document.querySelector('form[data-turbo-frame="' + turboFrameId + '"]');

    if (turboFrame) {
      turboFrame.requestSubmit();
    }
  }
}