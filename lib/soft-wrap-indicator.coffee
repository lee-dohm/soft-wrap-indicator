{CompositeDisposable} = require 'atom'

module.exports =
  # Public: Consumes the `status-bar` service.
  #
  # * `statusBar` Status bar service.
  consumeStatusBar: (statusBar) ->
    @observeEditors()

    SoftWrapStatusComponent = require './soft-wrap-status-component'
    @component = new SoftWrapStatusComponent
    @tile = statusBar.addLeftTile(item: @component.element, priority: 150)

  # Public: Deactivates the package.
  deactivate: ->
    @disposables?.dispose()
    @disposables = null
    @component?.destroy()
    @component = null
    @tile?.destroy()
    @tile = null

  # Private: Sets up observation of the active pane item.
  observeEditors: ->
    @disposables = new CompositeDisposable

    @disposables.add atom.workspace.observeTextEditors (editor) =>
      disposable = new CompositeDisposable

      disposable.add editor.onDidChangeGrammar =>
        @component?.update({editor})

      disposable.add editor.onDidChangeSoftWrapped =>
        @component?.update({editor})

      editor.onDidDestroy ->
        disposable.dispose()

    @disposables.add atom.workspace.onDidChangeActivePaneItem =>
      @component?.update({editor: atom.workspace.getActiveTextEditor()})
