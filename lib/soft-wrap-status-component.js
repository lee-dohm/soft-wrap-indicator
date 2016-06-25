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
    this.editor = atom.workspace.getActiveTextEditor()

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
    if (this.editor) {
      return (
        <IndicatorAnchor onclick={this.toggleSoftWrap.bind(this)}
                         wrapped={this.editor.isSoftWrapped()} />
      )
    }
  }

  toggleSoftWrap () {
    if (this.editor) {
      this.editor.toggleSoftWrapped()
    }
  }

  update (editor) {
    this.editor = editor

    return etch.update(this)
  }

  destroy () {
    etch.destroy(this)
  }
}
