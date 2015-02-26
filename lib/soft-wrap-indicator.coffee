module.exports =
  # Public: Activates the package.
  activate: ->

  # Public: Consumes the `status-bar` service.
  #
  # * `statusBar` Status bar service.
  consumeStatusBar: (@statusBar) ->
    SoftWrapIndicatorView = require './soft-wrap-indicator-view'
    @view = new SoftWrapIndicatorView()
    @view.initialize(statusBar)
    @view.attach()

  # Public: Deactivates the package.
  deactivate: ->
    @view?.destroy()
    @view = null
