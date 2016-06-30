'use babel'

import etch from 'etch'

import MockSoftWrapStatus from './mock-soft-wrap-status'
import SoftWrapStatusComponent from '../lib/soft-wrap-status-component'
import SynchronousScheduler from './etch-synchronous-scheduler'

describe('SoftWrapStatusComponent', function () {
  let previousScheduler, component, model

  beforeEach(function () {
    previousScheduler = etch.getScheduler()
    etch.setScheduler(new SynchronousScheduler())
  })

  afterEach(function () {
    etch.setScheduler(previousScheduler)
  })

  describe('when shouldRenderIndicator is false', function () {
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
    beforeEach(function () {
      model = new MockSoftWrapStatus(true, false)
      component = new SoftWrapStatusComponent(model)
      component.update()
    })

    it('renders the component', function () {
      expect(component.element.classList.contains('soft-wrap-status-component')).to.be.true
    })

    it('renders the indicator unlit', function () {
      indicator = component.element.querySelector('a.soft-wrap-indicator')

      expect(indicator).to.be.ok
      expect(indicator.classList.contains('lit')).to.be.false
    })
  })

  describe('when shouldRenderIndicator and shouldBeLit are both true', function () {
    beforeEach(function () {
      model = new MockSoftWrapStatus(true, true)
      component = new SoftWrapStatusComponent(model)
      component.update()
    })

    it('renders the component', function () {
      expect(component.element.classList.contains('soft-wrap-status-component')).to.be.true
    })

    it('renders the indicator lit', function () {
      indicator = component.element.querySelector('a.soft-wrap-indicator')

      expect(indicator).to.be.ok
      expect(indicator.classList.contains('lit')).to.be.true
    })
  })
})
