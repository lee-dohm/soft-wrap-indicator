{CompositeDisposable} = require 'atom'

# Public: Status bar indicator for the soft wrap status of the current editor.
class SoftWrapIndicatorView extends HTMLDivElement
  # Public: Initializes the indicator.
  #
  # * `statusBar` Status bar service.
  initialize: (@statusBar) ->
    @classList.add('inline-block')
    @wrapLink = document.createElement('a')
    @wrapLink.classList.add('soft-wrap-indicator', 'inline-block')
    @wrapLink.href = '#'
    @wrapLink.textContent = 'Wrap'
    @appendChild(@wrapLink)
    @handleEvents()

  # Public: Attaches the indicator to the {StatusBarView}.
  attach: ->
    @tile = @statusBar.addLeftTile(item: this, priority: 150)

  # Public: Destroys and removes the indicator.
  destroy: ->
    @editorSubscriptions?.dispose()
    @subscriptions?.dispose()
    @tile?.destroy()
    @tile = null

  # Private: Gets the active text editor.
  #
  # Returns the active {TextEditor}, if any.
  getActiveTextEditor: ->
    atom.workspace.getActiveTextEditor()

  # Private: Sets up the event handlers.
  handleEvents: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.workspace.onDidChangeActivePaneItem =>
      @subscribeToActiveTextEditor()

    clickHandler = =>
      @getActiveTextEditor()?.toggleSoftWrapped()
      false

    @addEventListener('click', clickHandler)
    @subscriptions.add dispose: => @removeEventListener('click', clickHandler)

    @subscribeToActiveTextEditor()

  # Private: Subscribes to the appropriate events on the active text editor when it changes.
  subscribeToActiveTextEditor: ->
    @editorSubscriptions?.dispose()

    @editorSubscriptions = new CompositeDisposable
    @editorSubscriptions.add @getActiveTextEditor()?.onDidChangeSoftWrapped => @update()
    @editorSubscriptions.add @getActiveTextEditor()?.onDidChangeGrammar => @update()

    @update()

  # Private: Shows the indicator.
  show: ->
    @style.display = ''

  # Private: Hides the indicator.
  hide: ->
    @style.display = 'none'

  # Private: Updates the content of the indicator.
  update: ->
    editor = @getActiveTextEditor()

    if editor?.isSoftWrapped()
      @wrapLink.classList.add('lit')
      @show()
    else if editor
      @wrapLink.classList.remove('lit')
      @show()
    else
      @hide()

module.exports = document.registerElement('soft-wrap-indicator',
                                          prototype: SoftWrapIndicatorView.prototype)
