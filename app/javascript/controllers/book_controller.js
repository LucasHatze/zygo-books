import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "btnSubmit" ]

  search() {  
    this.btnSubmitTarget.click()
  }
}
