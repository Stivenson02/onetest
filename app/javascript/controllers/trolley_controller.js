import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the Trolley Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  /*
   * Regular Stimulus lifecycle methods
   * Learn more at: https://stimulusjs.org/reference/lifecycle-callbacks
   *
   * If you intend to use this controller as a regular stimulus controller as well,
   * make sure any Stimulus lifecycle methods overridden in ApplicationController call super.
   *
   * Important:
   * By default, StimulusReflex overrides the -connect- method so make sure you
   * call super if you intend to do anything else when this controller connects.
  */

  connect () {
    super.connect()
    // add your code here, if applicable
  }

  /* Reflex specific lifecycle methods.
   *
   * For every method defined in your Reflex class, a matching set of lifecycle methods become available
   * in this javascript controller. These are optional, so feel free to delete these stubs if you don't
   * need them.
   *
   * Important:
   * Make sure to add data-controller="trolley" to your markup alongside
   * data-reflex="Trolley#dance" for the lifecycle methods to fire properly.
   *
   * Example:
   *
   *   <a href="#" data-reflex="click->Trolley#dance" data-controller="trolley">Dance!</a>
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "Trolley#dance"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */

  // beforeAddProduct(element, reflex, noop, reflexId) {
  //  console.log("before add_product", element, reflex, reflexId)
  // }

  // addProductSuccess(element, reflex, noop, reflexId) {
  //   console.log("add_product success", element, reflex, reflexId)
  // }

  // addProductError(element, reflex, error, reflexId) {
  //   console.error("add_product error", element, reflex, error, reflexId)
  // }

  // addProductHalted(element, reflex, noop, reflexId) {
  //   console.warn("add_product halted", element, reflex, reflexId)
  // }

  // afterAddProduct(element, reflex, noop, reflexId) {
  //   console.log("after add_product", element, reflex, reflexId)
  // }

  // finalizeAddProduct(element, reflex, noop, reflexId) {
  //   console.log("finalize add_product", element, reflex, reflexId)
  // }
}
