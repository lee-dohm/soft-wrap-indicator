{View} = require 'atom'

module.exports =
class SoftWrapIndicatorView extends View
  @content: ->
    @div class: 'inline-block', =>
      @span 'Wrap', class: 'soft-wrap-indicator', outlet: 'light'

  initialize: (@statusBar) ->
    @subscribe @statusBar, 'active-buffer-changed', @update

    atom.workspace.eachEditor (editor) =>
      @subscribe editor.displayBuffer, 'soft-wrap-changed', @update

  getActiveEditor: ->
    atom.workspace.getActiveEditor()

  update: =>
    if @getActiveEditor()?.getSoftWrap()
      @light.addClass('lit').show()
    else if @getActiveEditor()?
      @light.removeClass('lit').show()
    else
      @light.hide()

  # Tear down any state and detach
  destroy: ->
    @remove()
