module.exports =
  # Public: Consumes the `status-bar` service.
  #
  # * `statusBar` Status bar service.
  consumeStatusBar: (statusBar) ->
    SoftWrapStatus = require './soft-wrap-status'
    @model = new SoftWrapStatus()
    @tile = statusBar.addLeftTile(item: @model.view.element, priority: 150)

  # Public: Deactivates the package.
  deactivate: ->
    @model?.destroy
    @model = null
    @tile?.destroy()
    @tile = null
