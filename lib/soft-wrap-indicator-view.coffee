# Public: Status bar indicator for the soft wrap status of the current editor.
class SoftWrapIndicatorView extends HTMLElement
  # Public: Initializes the indicator.
  #
  # * `statusBar` The {StatusBarView} to attach the indicator to.
  initialize: (@statusBar) ->
    @classList.add('inline-block')
    @light = @createLink()
    @handleEvents()

  # Public: Attaches the indicator to the {StatusBarView}.
  attach: ->
    @tile = @statusBar?.addLeftTile(item: this, priority: 150)

  # Public: Destroys and removes the indicator.
  destroy: ->
    @grammarSubscription?.dispose()
    @clickSubscription?.dispose()
    @activeItemSubscription?.dispose()
    @remove()
    @tile?.destroy()
    @tile = null

  # Private: Creates the clickable link for toggling soft wrap.
  #
  # Returns the link.
  createLink: ->
    link = document.createElement('a')
    link.classList.add('soft-wrap-indicator', 'inline-block')
    link.href = '#'
    link.textContent = 'Wrap'
    @appendChild(link)

  # Private: Gets the active text editor.
  #
  # Returns the active {TextEditor}, if any.
  getActiveTextEditor: ->
    atom.workspace.getActiveTextEditor()

  # Private: Sets up the event handlers.
  handleEvents: ->
    @activeItemSubscritpion = atom.workspace.onDidChangeActivePaneItem =>
      @subscribeToActiveTextEditor()

    clickHandler = ->
      atom.workspace.getActiveTextEditor()?.toggleSoftWrap()
      false

    @addEventListener('click', clickHandler)
    @clickSubscription = dispose: => @removeEventListener('click', clickHandler)

    @subscribeToActiveTextEditor()

  # Private: Subscribes to the appropriate events on the active text editor when it changes.
  subscribeToActiveTextEditor: ->
    @grammarSubscription?.dispose()

    @grammarSubscription = @getActiveTextEditor()?.onDidChangeSoftWrapped =>
      @update()

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
      @light.classList.add('lit')
      @show()
    else if editor
      @light.classList.remove('lit')
      @show()
    else
      @hide()

module.exports = document.registerElement('soft-wrap-indicator',
                                          prototype: SoftWrapIndicatorView.prototype,
                                          extends: 'div')
