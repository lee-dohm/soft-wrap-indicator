{View} = require 'atom'

# Public: Status bar view for the soft wrap indicator.
module.exports =
class SoftWrapIndicatorView extends View
  @content: ->
    @div class: 'inline-block', =>
      @a 'Wrap', class: 'soft-wrap-indicator', outlet: 'light'

  # Public: Initializes the view by subscribing to various events.
  initialize: ->
    atom.workspace.onDidChangeActivePaneItem =>
      @update()

    atom.workspace.observeTextEditors (editor) =>
      editor.onDidChangeSoftWrapped =>
        @update()

    @subscribe this, 'click', ->
      atom.workspace.getActiveEditor()?.toggleSoftWrap()

  # Internal: Executed by the framework after the view is added to the status bar.
  afterAttach: ->
    @update()

  # Internal: Updates the indicator based on the current state of the application.
  update: ->
    editor = atom.workspace.getActiveEditor()

    if editor?.isSoftWrapped()
      @light.addClass('lit').show()
    else if editor
      @light.removeClass('lit').show()
    else
      @light.hide()

  # Internal: Tear down any state and detach.
  destroy: ->
    @remove()
