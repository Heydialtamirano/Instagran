// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//=require bootstrap-sprockets
import "bootstrap-sprockets"

Turbo.config.forms.confirm = (message, element) => {
    const dialog = insertConfirmModal(message, element);
  
    return new Promise((resolve) => {
      dialog.querySelector("[data-behavior='cancel']").addEventListener("click", () => {
        dialog.remove();
  
        resolve(false);
      }, { once: true })
      dialog.querySelector("[data-behavior='commit']").addEventListener("click", () => {
        dialog.remove();
  
        resolve(true);
      }, { once: true })
    })
  }

  function insertConfirmModal(message, element) {
    content = `
      <div id="confirm-modal">
        ${message}
        <button data-behavior="commit">Confirm</button>
        <button data-behavior="cancel">Cancel</button>
      </div>
    `
  
    document.body.insertAdjacentHTML('beforeend', content);
    document.activeElement.blur();
  
    return document.getElementById("confirm-modal");
  }