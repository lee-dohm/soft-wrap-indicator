'use babel'
/** @jsx etch.dom */

import etch from 'etch'
import stateless from 'etch-stateless'

const IndicatorAnchor = stateless(etch, ({onclick, wrapped}) => {
  let light = ''
  if (wrapped) {
    light = 'lit'
  } else {
    light = 'unlit'
  }

  return <a className={`status-${light}`} onclick={onclick} href="#">Wrap</a>
})

/**
 * Handles the UI for the status bar element.
 */
export default class SoftWrapStatusComponent {
  /**
   * Public: Initializes the default state of the component.
   */
  constructor () {
    this.editor = atom.workspace.getActiveTextEditor()

    etch.initialize(this)
  }

  /**
   * Public: Draws the component.
   *
   * @return {HTMLElement} HTML of the component.
   */
  render () {
    return (
      <div className="soft-wrap-status-component inline-block">
        {this.renderIndicator()}
      </div>
    )
  }

  /**
   * Public: Updates the state of the component before being redrawn.
   *
   * @param  {TextEditor} editor Editor to track the state of.
   * @return {Promise} Resolved when the component is done updating.
   */
  update (editor) {
    this.editor = editor

    return etch.update(this)
  }

  /**
   * Public: Destroys the component.
   */
  destroy () {
    etch.destroy(this)
  }

  /**
   * Private: Draws the clickable indicator, if necessary.
   *
   * When there is no active editor, the indicator should not be shown. Therefore the anchor isn't
   * drawn.
   *
   * @return {HTMLElement} HTML of the clickable indicator.
   */
  renderIndicator () {
    if (this.editor) {
      return (
        <IndicatorAnchor onclick={this.toggleSoftWrap.bind(this)}
                         wrapped={this.editor.isSoftWrapped()} />
      )
    }
  }

  /**
   * Private: Toggles the soft wrap on the currently tracked editor.
   */
  toggleSoftWrap () {
    if (this.editor) {
      this.editor.toggleSoftWrapped()
    }
  }
}
