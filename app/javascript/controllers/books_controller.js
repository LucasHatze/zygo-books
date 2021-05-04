import { Controller } from "stimulus"

var _action;

export default class extends Controller {
  static targets = [ "form", "btnSubmit" ]

  search() {
    let _target = this
    clearTimeout(_action)
    _action = setTimeout(function(){
      _target.btnSubmitTarget.click()
    }, 400)
  }
}
