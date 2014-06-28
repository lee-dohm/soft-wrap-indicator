{View} = require 'atom'

module.exports =
class SoftWrapIndicatorView extends View
  @content: ->
    @div class: 'soft-wrap-indicator inline-block', =>
      @span 'Wrap'

  # Tear down any state and detach
  destroy: ->
    @detach()
