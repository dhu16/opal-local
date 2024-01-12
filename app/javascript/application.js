import Rails from "@rails/ujs"
import * as Turbo from "@hotwired/turbo"
import "controllers"

Rails.start()
Turbo.start()

document.addEventListener('turbo:load', () => {
  // Initialize or re-initialize Webflow scripts or other plugins
  Webflow.ready();
});
