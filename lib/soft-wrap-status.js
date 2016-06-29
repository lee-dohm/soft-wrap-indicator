'use babel'

import {CompositeDisposable} from 'atom'
import SoftWrapStatusComponent from './soft-wrap-status-component'

/**
 * Handles the logic behind the soft wrap indicator.
 *
 * The model and its view are tied 1:1. But the model will always track the currently active editor
 * if one exists.
 */
export default class SoftWrapStatus {
  /**
   * Public: Builds the new model.
   *
   * @param  {TextEditor} editor Editor to display the status of.
   */
  constructor (atomEnv = global.atom, editor = atomEnv.workspace.getActiveTextEditor()) {
    this.view = new SoftWrapStatusComponent(this)
    this.setActiveEditor(editor)
    this.workspaceSubscription = atomEnv.workspace.onDidChangeActivePaneItem(() => {
      this.setActiveEditor(atomEnv.workspace.getActiveTextEditor())
    })
  }

  /**
   * Public: Cleans up the indicator.
   */
  destroy () {
    this.workspaceSubscription.dispose()
    this.unsubscribe()
    this.view.destroy()
  }

  /**
   * Public: Indicates whether to display the indicator.
   *
   * @return {Boolean} truthy if the soft wrap indicator should be displayed, falsy otherwise.
   */
  shouldRenderIndicator () {
    return this.editor
  }

  /**
   * Public: Indicates whether the indicator should be lit.
   *
   * When the indicator is lit, it signifies that the currently active text editor has soft wrap
   * enabled.
   *
   * @return {Boolean} truthy if the indicator should be lit, falsy otherwise.
   */
  shouldBeLit () {
    return this.editor && this.editor.isSoftWrapped()
  }

  /**
   * Public: Toggles the soft wrap state of the currently tracked editor.
   */
  toggleSoftWrapped () {
    if (this.editor) {
      this.editor.toggleSoftWrapped()
    }
  }

  /**
   * Private: Sets the editor whose state the model is tracking.
   *
   * @param {TextEditor} editor Editor to display the soft wrap status for or `null` if the active
   *                            pane item is not an editor.
   */
  setActiveEditor (editor) {
    this.editor = editor
    this.subscribe(this.editor)
    this.view.update()
  }

  /**
   * Private: Subscribes to the state of a new editor.
   *
   * @param  {TextEditor} editor Editor to whose events the model should subscribe, if any.
   */
  subscribe (editor) {
    this.unsubscribe()

    if (editor) {
      this.editorSubscriptions = new CompositeDisposable

      this.editorSubscriptions.add(editor.onDidChangeGrammar(() => {
        this.view.update()
      }))

      this.editorSubscriptions.add(editor.onDidChangeSoftWrapped(() => {
        this.view.update()
      }))

      this.editorSubscriptions.add(editor.onDidDestroy(() => {
        this.unsubscribe()
      }))
    }
  }

  /**
   * Private: Unsubscribes from the old editor's events.
   */
  unsubscribe () {
    if (this.editorSubscriptions) {
      this.editorSubscriptions.dispose()
      this.editorSubscriptions = null
    }
  }
}