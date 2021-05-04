import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "btnSubmit" ]

  search() {
    let _target = this
    clearTimeout()
    setTimeout(function(){
      _target.btnSubmitTarget.click()
    }, 800)
  }
}
