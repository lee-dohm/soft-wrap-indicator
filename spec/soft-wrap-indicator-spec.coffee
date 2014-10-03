{WorkspaceView} = require 'atom'

describe 'SoftWrapIndicator', ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model

    waitsForPromise -> atom.packages.activatePackage('status-bar')
    waitsForPromise -> atom.packages.activatePackage('soft-wrap-indicator')

    runs ->
      atom.packages.emit('activated')
      atom.workspaceView.simulateDomAttachment()

  indicatorLit = ->
    atom.workspaceView.find('.soft-wrap-indicator.lit').length is 1

  describe '.initialize', ->
    it 'displays in the status bar', ->
      expect(atom.workspaceView.find('.soft-wrap-indicator').length).toBe 1

    it 'has indicator text', ->
      view = atom.workspaceView.find('.soft-wrap-indicator')
      expect(view.text()).toBe 'Wrap'

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
      view = atom.workspaceView.find('.soft-wrap-indicator')
      expect(view).toExist()

      atom.packages.deactivatePackage('soft-wrap-indicator')

      view = atom.workspaceView.find('.soft-wrap-indicator')
      expect(view).not.toExist()

    it 'can be executed twice', ->
      atom.packages.deactivatePackage('soft-wrap-indicator')
      atom.packages.deactivatePackage('soft-wrap-indicator')
