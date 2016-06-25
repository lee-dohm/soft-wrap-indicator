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

export default class SoftWrapStatusComponent {
  constructor () {
    this.visible = true
    this.softWrapped = false

    etch.initialize(this)
  }

  render () {
    return (
      <div className="soft-wrap-status-component inline-block">
        {this.renderIndicator()}
      </div>
    )
  }

  renderIndicator () {
    if (this.visible) {
      return <IndicatorAnchor onclick={this.toggleSoftWrap.bind(this)} wrapped={this.softWrapped} />
    }
  }

  toggleSoftWrap () {
    atom.workspace.getActiveTextEditor().toggleSoftWrapped()
  }

  update ({visible, softWrapped}) {
    this.visible = visible
    this.softWrapped = softWrapped

    return etch.update(this)
  }

  destroy () {
    etch.destroy(this)
  }
}
