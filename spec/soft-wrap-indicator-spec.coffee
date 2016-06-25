SoftWrapIndicator = require '../lib/soft-wrap-indicator'

describe 'SoftWrapIndicator', ->
  [indicator] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise -> atom.packages.activatePackage('status-bar')
    waitsForPromise -> atom.packages.activatePackage('language-javascript')
    waitsForPromise -> atom.packages.activatePackage('language-gfm')
    waitsForPromise -> atom.packages.activatePackage('soft-wrap-indicator')

    runs ->
      indicator = SoftWrapIndicator.component.element
      expect(indicator).toExist()

  describe 'when no editor is open', ->
    it 'hides the indicator when there is no open editor', ->
      expect(indicator.querySelector('a')).toBeNull()

  describe 'when an editor is open', ->
    [editor] = []

    beforeEach ->
      waitsForPromise ->
        atom.workspace.open('sample.js')

      runs ->
        editor = atom.workspace.getActiveTextEditor()

    it 'shows the indicator', ->
      expect(indicator.querySelector('a')).not.toBeNull()

    it 'is not lit when the grammar is not soft wrapped', ->
      anchor = indicator.querySelector('a')

      expect(anchor.classList.contains('status-lit')).toBeFalsy()

    it 'is lit when the grammar is soft wrapped', ->
      waitsForPromise ->
        atom.workspace.open('sample.md')

      runs ->
        anchor = indicator.querySelector('a')

        expect(anchor.classList.contains('status-lit')).toBeTruthy()

    it 'is lit when the soft wrap setting is changed', ->
      editor.toggleSoftWrapped()

      anchor = indicator.querySelector('a')

      expect(anchor.classList.contains('status-lit')).toBeTruthy()

    it 'is lit when the grammar is changed to a soft wrapped grammar', ->
      grammar = atom.grammars.grammarForScopeName('source.gfm')
      editor.setGrammar(grammar)

      anchor = indicator.querySelector('a')

      expect(anchor.classList.contains('status-lit')).toBeTruthy()

    describe 'when clicked', ->
      it 'toggles the soft wrap value', ->
        spyOn(editor, 'toggleSoftWrapped')

        anchor = indicator.querySelector('a')
        anchor.click()
        expect(editor.toggleSoftWrapped).toHaveBeenCalled()

  describe 'when the package is deactivated', ->
    it 'removes the indicator', ->
      atom.packages.deactivatePackage('soft-wrap-indicator')

      expect(indicator.parentElement).toBeNull()
