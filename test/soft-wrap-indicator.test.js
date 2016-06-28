'use babel'

const SoftWrapIndicator = require('../lib/soft-wrap-indicator')

describe('SoftWrapIndicatorPackage', function () {
  let indicator

  beforeEach(async function () {
    await atom.packages.activatePackage('status-bar')
    await atom.packages.activatePackage('language-javascript')
    await atom.packages.activatePackage('language-gfm')
    await atom.packages.activatePackage('soft-wrap-indicator')

    expect(SoftWrapIndicator.deactivate).to.be.ok
    indicator = SoftWrapIndicator.component.element
  })

  afterEach(function () {
    atom.destroy()
  })

  it('creates an indicator element', function () {
    expect(indicator).to.be.ok
  })
})
