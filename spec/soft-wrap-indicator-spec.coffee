SoftWrapIndicator = require '../lib/soft-wrap-indicator'

describe 'SoftWrapIndicator', ->
  [indicator, workspaceElement] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise -> atom.packages.activatePackage('status-bar')
    waitsForPromise -> atom.packages.activatePackage('soft-wrap-indicator')

    runs ->
      atom.packages.emitter.emit('did-activate-all')

      indicator = SoftWrapIndicator.view

  indicatorLit = ->
    indicator.querySelector('.lit')

  describe '.initialize', ->
    it 'displays in the status bar', ->
      expect(indicator).toBeDefined()
      expect(indicator.querySelector('.soft-wrap-indicator')).toBeTruthy()

    it 'has indicator text', ->
      expect(indicator.textContent).toBe 'Wrap'

    it 'is not lit if soft wrap is off', ->
      waitsForPromise ->
        atom.workspace.open('sample.js')

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editor.setSoftWrapped(false)
        expect(indicatorLit()).toBeFalsy()

    it 'is lit if soft wrap is on', ->
      waitsForPromise ->
        atom.workspace.open('sample.js')

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editor.setSoftWrapped(true)
        expect(indicatorLit()).toBeTruthy()

  describe '.deactivate', ->
    it 'removes the indicator view', ->
      expect(indicator).toExist()

      atom.packages.deactivatePackage('soft-wrap-indicator')

      expect(SoftWrapIndicator.view).toBeNull()

    it 'can be executed twice', ->
      atom.packages.deactivatePackage('soft-wrap-indicator')
      atom.packages.deactivatePackage('soft-wrap-indicator')
