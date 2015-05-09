{CompositeDisposable} = require 'atom'

module.exports =
  # Public: Consumes the `status-bar` service.
  #
  # * `statusBar` Status bar service.
  consumeStatusBar: (statusBar) ->
    @observeEditors()

    SoftWrapIndicatorView = require './soft-wrap-indicator-view'
    @view = new SoftWrapIndicatorView()
    @view.initialize()
    @tile = statusBar.addLeftTile(item: @view, priority: 150)

  # Public: Deactivates the package.
  deactivate: ->
    @osberver?.dispose()
    @observer = null
    @view?.destroy()
    @view = null
    @tile?.destroy()
    @tile = null

  # Private: Sets up observation of text editors.
  observeEditors: ->
    @observer = atom.workspace.observeTextEditors (editor) =>
      disposables = new CompositeDisposable

      disposables.add editor.onDidChangeGrammar =>
        @view?.update(editor)

      disposables.add editor.onDidChangeSoftWrapped =>
        @view?.update(editor)

      editor.onDidDestroy ->
        disposables.dispose()
