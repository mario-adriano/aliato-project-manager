import consumer from "./../consumer"

document.addEventListener("turbo:load", function() {
  consumer.subscriptions.create("Admin::PhasesChannel", {
    connected() {
      console.log("Conectado ao Admin::PhasesChannel");
    },

    disconnected() {
      console.log("Desconectado do Admin::PhasesChannel");
    },

    received(data) {
      console.log("Dados recebidos:", data);
      if (data.type === "update_order") {
        const phaseTable = document.getElementById('phases_table');
        phaseTable.innerHTML = data.html;
      } else {
        const phaseContainer = document.getElementById(`is_end_${data.phase_id}`);
        if (phaseContainer) {
          phaseContainer.innerHTML = data.html;
        }
      }
    }
  });
});
