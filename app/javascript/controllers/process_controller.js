import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {
  static targets = ["output"]

  connect() {
    StimulusReflex.register(this)
    this.startListing()
  }

  disconnect() {
    this.stopRefreshing()
  }

  startListing() {
    this.refreshTimer = setInterval(() => {
      this.stimulate('ProcessReflex#list')
    }, 2000)
    // }, this.data.get("refreshInterval"))
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }
}
