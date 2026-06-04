import React from 'react'
import HeaderTopLinks from '../top-links'
import { create } from 'react-test-renderer'
import { Provider } from 'react-redux'
import mockStore from '../../../../store/__mocks__/mockStore'

describe('HeaderTopLinks Component', () => {
  it('should match snapshot', () => {
    const tree = create(
      <Provider store={mockStore}>
        <HeaderTopLinks />
      </Provider>
    ).toJSON()
    expect(tree).toMatchSnapshot()
  })
})
