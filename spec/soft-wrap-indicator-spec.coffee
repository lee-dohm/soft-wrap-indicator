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
      indicator = SoftWrapIndicator.view
      expect(indicator).toExist()

  describe 'when no editor is open', ->
    it 'has the text "Wrap"', ->
      expect(indicator.link.textContent).toBe 'Wrap'

    it 'hides the indicator when there is no open editor', ->
      expect(indicator).toBeHidden()

  describe 'when an editor is open', ->
    [editor] = []

    beforeEach ->
      waitsForPromise ->
        atom.workspace.open('sample.js')

      runs ->
        editor = atom.workspace.getActiveTextEditor()

    it 'shows the indicator', ->
      expect(indicator).not.toBeHidden()

    it 'is not lit when the grammar is not soft wrapped', ->
      expect(indicator.link.classList.contains('lit')).toBeFalsy()

    it 'is lit when the grammar is soft wrapped', ->
      waitsForPromise ->
        atom.workspace.open('sample.md')

      runs ->
        expect(indicator.link.classList.contains('lit')).toBeTruthy()

    it 'is lit when the soft wrap setting is changed', ->
      editor.toggleSoftWrapped()

      expect(indicator.link.classList.contains('lit')).toBeTruthy()

    it 'is lit when the grammar is changed to a soft wrapped grammar', ->
      grammar = atom.grammars.grammarForScopeName('source.gfm')
      editor.setGrammar(grammar)

      expect(indicator.link.classList.contains('lit')).toBeTruthy()

    describe 'when clicked', ->
      it 'toggles the soft wrap value', ->
        spyOn(editor, 'toggleSoftWrapped')
        indicator.click()
        expect(editor.toggleSoftWrapped).toHaveBeenCalled()

  describe 'when the package is deactivated', ->
    it 'removes the indicator', ->
      atom.packages.deactivatePackage('soft-wrap-indicator')

      expect(indicator.parentElement).toBeNull()
