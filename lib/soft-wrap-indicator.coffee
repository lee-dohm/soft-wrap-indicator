SoftWrapIndicatorView = require './soft-wrap-indicator-view'

# Handles the activation and deactivation of the package.
class SoftWrapIndicator
  view: null

  # Activates the package.
  activate: ->
    atom.packages.once 'activated', =>
      statusBar = atom.workspaceView.statusBar
      if statusBar
        @view = new SoftWrapIndicatorView
        statusBar.appendLeft(@view)

  # Deactivates the package.
  deactivate: ->
    @view?.destroy()

module.exports = new SoftWrapIndicator()
