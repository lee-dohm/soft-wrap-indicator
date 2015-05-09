{CompositeDisposable, Disposable} = require 'atom'

class SoftWrapIndicatorView extends HTMLElement
  initialize: ->
    @classList.add('inline-block')
    @addLink()
    @createEventHandlers()

  addLink: ->
    @link = document.createElement('a')
    @link.classList.add('soft-wrap-indicator', 'inline-block')
    @link.href = '#'
    @link.textContent = 'Wrap'

    @appendChild(@link)

  createEventHandlers: ->
    @disposables = new CompositeDisposable

    @createActivePaneHandler()
    @createClickHandler()

  createActivePaneHandler: ->
    @disposables.add atom.workspace.onDidChangeActivePaneItem =>
      @update()

  createClickHandler: ->
    clickHandler = ->
      atom.workspace.getActiveTextEditor()?.toggleSoftWrapped()
      false

    @addEventListener('click', clickHandler)
    disposable = new Disposable =>
      @removeEventListener('click', clickHandler)

    @disposables.add disposable

  destroy: ->
    @disposables?.dispose()
    @disposables = null

  update: ->


module.exports = document.registerElement('status-bar-soft-wrap',
                                          prototype: SoftWrapIndicatorView.prototype,
                                          extends: 'div')
