import React from 'react'
import CopyLink from '../copyLink'
import { create } from 'react-test-renderer'

describe('CopyLink Component', () => {
  it('should match snapshot', () => {
    const tree = create(
      <CopyLink
        url="https://github.com/Vsocial/Vsocial"
        label="Copy Link"
        done={jest.fn()}
      />
    ).toJSON()

    expect(tree).toMatchSnapshot()
  })
})
