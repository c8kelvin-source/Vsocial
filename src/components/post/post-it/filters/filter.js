import React from 'react'
import { c_first } from '../../../../utils/utils'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { CPP } from '../../../../actions/post'
import classNames from 'classnames'

const Filter = ({ filter, previewImg, contrastVal, activeFilter, dispatch }) => {
  let f = filter.replace('filter-', '')

  let select = () => {
    dispatch(CPP('filter', filter))
  }

  const isSelected = activeFilter === filter

  return (
    <div
      className={classNames('filter_div', `fp_${filter}`, {
        select_receiver_toggle: isSelected,
      })}
      onClick={select}
    >
      <img className={filter} src={previewImg} style={{ filter: `contrast(${contrastVal}%)` }} />
      <span>{c_first(f)}</span>
    </div>
  )
}

Filter.propTypes = {
  filter: PropTypes.string.isRequired,
}

const mapStateToProps = state => {
  const postIt = state.Post.postIt
  const mediaFiles = postIt.mediaFiles || []
  const activeIdx = postIt.activeMediaIdx || 0
  const activeFile = mediaFiles[activeIdx]

  const filterStr = activeFile ? activeFile.filter || 'filter-normal' : 'filter-normal'
  const parts = filterStr.split(' ')
  const contrastPart = parts.find(p => p.startsWith('contrast-'))
  const contrastVal = contrastPart ? parseInt(contrastPart.replace('contrast-', ''), 10) : 100

  return {
    previewImg: postIt.previewImg,
    activeFilter: postIt.filter,
    contrastVal,
  }
}

export default connect(mapStateToProps)(Filter)
export { Filter as PureFilter }
