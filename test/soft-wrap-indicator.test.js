'use babel'

SoftWrapIndicator = require('../lib/soft-wrap-indicator')

describe('SoftWrapIndicatorPackage', () => {
  let atomEnv, indicator

  beforeEach(async () => {
    atomEnv = global.buildAtomEnvironment()
    let workspace = atomEnv.workspace
    let workspaceElement = atomEnv.views.getView(workspace)

    await atomEnv.packages.activatePackage('status-bar')
    await atomEnv.packages.activatePackage('language-javascript')
    await atomEnv.packages.activatePackage('language-gfm')
    await atomEnv.packages.activatePackage('soft-wrap-indicator')

    expect(SoftWrapIndicator.deactivate).to.be.ok
    indicator = SoftWrapIndicator.component.element
  })

  afterEach(() => {
    atomEnv.destroy()
  })

  it('creates an indicator element', () => {
    expect(indicator).to.be.ok
  })
})
