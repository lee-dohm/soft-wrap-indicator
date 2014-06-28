SoftWrapIndicatorView = require './soft-wrap-indicator-view'

class SoftWrapIndicator
  view: null

  activate: ->
    atom.packages.once 'activated', =>
      statusBar = atom.workspaceView.statusBar
      if statusBar?
        @view = new SoftWrapIndicatorView(statusBar)
        statusBar.appendLeft(@view)

  deactivate: ->
    @view?.destroy()

module.exports = new SoftWrapIndicator()
