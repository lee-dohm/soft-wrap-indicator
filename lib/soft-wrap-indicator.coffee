SoftWrapIndicatorView = require './soft-wrap-indicator-view'

class SoftWrapIndicator
  view: null

  activate: ->
    atom.packages.once 'activated', =>
      @view = new SoftWrapIndicatorView()
      atom.workspaceView.statusBar?.appendLeft(@view)

    atom.workspaceView.eachEditorView (view) =>
      view.on 'focus', =>
        if view.getEditor().getSoftWrap()
          @view.addClass('lit')
        else
          @view.removeClass('lit')

  deactivate: ->
    @view.destroy()

module.exports = new SoftWrapIndicator()
