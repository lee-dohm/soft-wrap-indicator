{View} = require 'atom'

# Public: Status bar view for the soft wrap indicator.
module.exports =
class SoftWrapIndicatorView extends View
  @content: ->
    @div class: 'inline-block', =>
      @a 'Wrap', class: 'soft-wrap-indicator', outlet: 'light'

  # Public: Initializes the view by subscribing to various events.
  #
  # statusBar - {StatusBar} of the application
  initialize: (@statusBar) ->
    @subscribe @statusBar, 'active-buffer-changed', @update

    atom.workspace.eachEditor (editor) =>
      @subscribe editor.displayBuffer, 'soft-wrap-changed', @update

    @subscribe this, 'click', => @getActiveEditor()?.toggleSoftWrap()

  # Internal: Executed by the framework after the view is added to the status bar.
  afterAttach: ->
    @update()

  # Internal: Gets the currently active `Editor`.
  #
  # Returns the {Editor} that is currently active or `null` if there is not one active.
  getActiveEditor: ->
    atom.workspace.getActiveEditor()

  # Internal: Updates the indicator based on the current state of the application.
  update: =>
    if @getActiveEditor()?.isSoftWrapped()
      @light.addClass('lit').show()
    else if @getActiveEditor()?
      @light.removeClass('lit').show()
    else
      @light.hide()

  # Internal: Tear down any state and detach.
  destroy: ->
    @remove()
