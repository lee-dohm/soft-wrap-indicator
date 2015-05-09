{CompositeDisposable, Disposable} = require 'atom'

# Public: Creates a soft wrap indicator to be placed into the status bar.
class SoftWrapIndicatorView extends HTMLElement
  # Public: Initializes the element.
  initialize: ->
    @classList.add('inline-block')
    @addLink()
    @createEventHandlers()

    @update()

  # Public: Destroys the indicator.
  destroy: ->
    @disposables?.dispose()
    @disposables = null

  # Public: Updates the indicator with the status from the given editor.
  #
  # * `editor` {TextEditor} to indicate the soft wrap status for.
  update: (editor = atom.workspace.getActiveTextEditor()) ->
    if editor?.isSoftWrapped()
      @link.classList.add('lit')
      @style.display = ''
    else if editor
      @link.classList.remove('lit')
      @style.display = ''
    else
      @style.display = 'none'

  # Private: Adds the link to toggle the soft wrap state for the active editor.
  addLink: ->
    @link = document.createElement('a')
    @link.classList.add('soft-wrap-indicator', 'inline-block')
    @link.href = '#'
    @link.textContent = 'Wrap'

    @appendChild(@link)

  # Private: Creates all necessary event handlers.
  createEventHandlers: ->
    @disposables = new CompositeDisposable

    @createActivePaneHandler()
    @createClickHandler()

  # Private: Creates the handler for when the active pane item changes.
  createActivePaneHandler: ->
    @disposables.add atom.workspace.onDidChangeActivePaneItem =>
      @update()

  # Private: Creates the click handler for the soft wrap toggle.
  createClickHandler: ->
    clickHandler = ->
      atom.workspace.getActiveTextEditor()?.toggleSoftWrapped()
      false

    @addEventListener('click', clickHandler)
    disposable = new Disposable =>
      @removeEventListener('click', clickHandler)

    @disposables.add disposable

module.exports = document.registerElement('status-bar-soft-wrap',
                                          prototype: SoftWrapIndicatorView.prototype,
                                          extends: 'div')
