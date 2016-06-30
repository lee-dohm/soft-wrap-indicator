'use babel'

export default class MockSoftWrapStatus {
  constructor (shouldRenderIndicator, shouldBeLit) {
    this.render = shouldRenderIndicator
    this.light = shouldBeLit
  }

  shouldBeLit () {
    return this.light
  }

  shouldRenderIndicator () {
    return this.render
  }

  toggleSoftWrapped () {
    return undefined
  }
}
