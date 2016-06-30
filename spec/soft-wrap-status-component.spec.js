'use babel'

import etch from 'etch'

import MockSoftWrapStatus from './mock-soft-wrap-status'
import SoftWrapStatusComponent from '../lib/soft-wrap-status-component'
import SynchronousScheduler from './etch-synchronous-scheduler'

describe('SoftWrapStatusComponent', function () {
  let previousScheduler

  beforeEach(function () {
    previousScheduler = etch.getScheduler()
    etch.setScheduler(new SynchronousScheduler())
  })

  afterEach(function () {
    etch.setScheduler(previousScheduler)
  })

  describe('when shouldRenderIndicator is false', function () {
    let component, model

    beforeEach(function () {
      model = new MockSoftWrapStatus(false, false)
      component = new SoftWrapStatusComponent(model)
      component.update()
    })

    it('renders the component', function () {
      expect(component.element.classList.contains('soft-wrap-status-component')).to.be.true
    })

    it('does not render the indicator', function () {
      expect(component.element.querySelector('a.soft-wrap-indicator')).to.be.null
    })
  })

  describe('when shouldRenderIndicator is true', function () {
    let component, model

    beforeEach(function () {
      model = new MockSoftWrapStatus(true, false)
      component = new SoftWrapStatusComponent(model)
      component.update()
    })

    it('renders the component', function () {
      expect(component.element.classList.contains('soft-wrap-status-component')).to.be.true
    })

    it('renders the indicator unlit', function () {
      expect(component.element.querySelector('a.soft-wrap-indicator')).to.be.ok
      expect(component.element.querySelector('a.lit')).to.be.null
    })
  })

  describe('when shouldRenderIndicator and shouldBeLit are both true', function () {
    let component, model

    beforeEach(function () {
      model = new MockSoftWrapStatus(true, true)
      component = new SoftWrapStatusComponent(model)
      component.update()
    })

    it('renders the component', function () {
      expect(component.element.classList.contains('soft-wrap-status-component')).to.be.true
    })

    it('renders the indicator lit', function () {
      expect(component.element.querySelector('a.soft-wrap-indicator')).to.be.ok
      expect(component.element.querySelector('a.lit')).to.be.ok
    })
  })
})
