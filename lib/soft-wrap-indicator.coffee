# Handles the activation and deactivation of the package.
class SoftWrapIndicator
  view: null

  # Activates the package.
  activate: ->
    atom.packages.once 'activated', =>
      statusBar = document.querySelector('status-bar')
      if statusBar?
        SoftWrapIndicatorView = require './soft-wrap-indicator-view'
        @view = new SoftWrapIndicatorView
        @view.initialize(statusBar)
        @view.attach()

  # Deactivates the package.
  deactivate: ->
    @view?.destroy()

module.exports = new SoftWrapIndicator()
