import React, { Component } from 'react'
import { connect } from 'react-redux'
import { CPP } from '../../../actions/post'

/**
 * MediaPreview — drag-and-drop reorderable grid of selected files.
 * Class component (no hooks) for compatibility with React < 16.8.
 */
class MediaPreview extends Component {
  constructor(props) {
    super(props)
    this.state = {
      dragIdx: null,
      overIdx: null,
    }
    this.fileInputEl = null // callback ref, works in all React versions
  }

  dp = (...args) => this.props.dispatch(CPP(...args))

  reorder = (from, to) => {
    const { mediaFiles, activeMediaIdx } = this.props
    if (from === null || from === to || to === null) return
    const updated = mediaFiles.slice()
    const moved = updated.splice(from, 1)[0]
    updated.splice(to, 0, moved)
    this.dp('mediaFiles', updated)

    let nextActive = activeMediaIdx || 0
    if (nextActive === from) {
      nextActive = to
    } else if (from < nextActive && to >= nextActive) {
      nextActive -= 1
    } else if (from > nextActive && to <= nextActive) {
      nextActive += 1
    }
    this.selectActive(nextActive, updated)
  }

  removeFile = idx => {
    const { mediaFiles, activeMediaIdx } = this.props
    const updated = mediaFiles.filter((_, i) => i !== idx)
    this.dp('mediaFiles', updated)
    if (updated.length === 0) {
      this.dp('fileChanged', false)
      this.dp('previewImg', '/images/location.jpg')
      this.dp('targetFile', '')
      this.dp('activeMediaIdx', 0)
    } else {
      let nextActive = activeMediaIdx || 0
      if (nextActive >= updated.length) {
        nextActive = updated.length - 1
      }
      this.selectActive(nextActive, updated)
    }
  }

  selectActive = (idx, customMediaFiles) => {
    const mediaFiles = customMediaFiles || this.props.mediaFiles
    const entry = mediaFiles[idx]
    if (!entry) return
    this.dp('activeMediaIdx', idx)
    this.dp('previewImg', entry.previewUrl)
    this.dp('targetFile', entry.file)
    this.dp('filter', entry.filter || 'filter-normal')
  }

  changeContrast = (idx, value) => {
    const { mediaFiles } = this.props
    const updated = mediaFiles.slice()
    const entry = updated[idx]
    if (!entry) return

    const parts = (entry.filter || 'filter-normal').split(' ')
    const filterClass = parts[0] || 'filter-normal'
    entry.filter = `${filterClass} contrast-${value}`

    this.dp('mediaFiles', updated)

    // Sync to main preview filter if this is the active index
    const activeIdx = this.props.activeMediaIdx || 0
    if (idx === activeIdx) {
      this.dp('filter', entry.filter)
    }
  }

  addMore = e => {
    const rawFiles = e.target.files
    if (!rawFiles || !rawFiles.length) return
    const newFiles = Array.from(rawFiles)
    const { mediaFiles } = this.props

    const readers = newFiles.map(
      file =>
        new Promise(resolve => {
          const reader = new FileReader()
          reader.onload = ev =>
            resolve({ file, previewUrl: ev.target.result, filter: 'filter-normal' })
          reader.readAsDataURL(file)
        })
    )

    Promise.all(readers).then(newEntries => {
      const updated = mediaFiles.concat(newEntries)
      this.dp('mediaFiles', updated)
      this.dp('fileChanged', true)
      const activeIdx = this.props.activeMediaIdx || 0
      this.selectActive(activeIdx, updated)
    })
  }

  render() {
    const { mediaFiles, activeMediaIdx } = this.props
    const { dragIdx, overIdx } = this.state

    return (
      <div style={styles.container}>
        <div style={styles.grid}>
          {mediaFiles.map((item, idx) => {
            const isVideo = item.previewUrl && item.previewUrl.startsWith('data:video/')
            const isDragging = dragIdx === idx
            const isOver = overIdx === idx && !isDragging
            const isActive = (activeMediaIdx || 0) === idx

            // Parse filter class and contrast value
            const parts = (item.filter || 'filter-normal').split(' ')
            const filterClass = parts[0] || 'filter-normal'
            const contrastPart = parts.find(p => p.startsWith('contrast-'))
            const contrastVal = contrastPart ? parseInt(contrastPart.replace('contrast-', ''), 10) : 100

            return (
              <div
                key={idx}
                style={Object.assign({}, styles.gridItem, {
                  border: isActive ? '2px solid #6c63ff' : '2px solid transparent',
                  opacity: isDragging ? 0.4 : 1,
                })}
                onClick={() => this.selectActive(idx)}
              >
                {/* Draggable Thumbnail Wrapper */}
                <div
                  draggable
                  onDragStart={() => this.setState({ dragIdx: idx })}
                  onDragEnd={() => this.setState({ dragIdx: null, overIdx: null })}
                  onDragOver={e => { e.preventDefault(); this.setState({ overIdx: idx }) }}
                  onDrop={() => {
                    this.reorder(this.state.dragIdx, this.state.overIdx)
                    this.setState({ dragIdx: null, overIdx: null })
                  }}
                  style={Object.assign({}, styles.thumbnailWrap, {
                    outline: isOver ? '2px dashed #6c63ff' : 'none',
                  })}
                >
                  {/* Order badge */}
                  <div style={styles.badge}>{idx + 1}</div>

                  {/* Remove button */}
                  <button
                    style={styles.removeBtn}
                    onClick={e => { e.stopPropagation(); this.removeFile(idx) }}
                    title="Remove"
                  >
                    ✕
                  </button>

                  {/* Drag hint */}
                  <div style={styles.dragHint}>⠿</div>

                  {isVideo ? (
                    <video
                      src={item.previewUrl}
                      style={Object.assign({}, styles.media, { filter: `contrast(${contrastVal}%)` })}
                      muted
                    />
                  ) : (
                    <img
                      src={item.previewUrl}
                      className={filterClass}
                      alt={'Preview ' + (idx + 1)}
                      style={Object.assign({}, styles.media, { filter: `contrast(${contrastVal}%)` })}
                      draggable={false}
                    />
                  )}
                </div>

                {/* Contrast Slider */}
                <div style={styles.sliderContainer} onClick={e => e.stopPropagation()}>
                  <input
                    type="range"
                    min="50"
                    max="200"
                    value={contrastVal}
                    onChange={e => this.changeContrast(idx, e.target.value)}
                    style={styles.slider}
                  />
                  <div style={styles.sliderLabel}>Contrast: {contrastVal}%</div>
                </div>
              </div>
            )
          })}

          {/* Add more button */}
          <div
            style={styles.addMore}
            onClick={() => this.fileInputEl && this.fileInputEl.click()}
            title="Add more files"
          >
            <span style={styles.addMoreIcon}>+</span>
            <span style={styles.addMoreLabel}>Add more</span>
          </div>
        </div>

        <input
          ref={el => { this.fileInputEl = el }}
          type="file"
          accept="image/*,video/*"
          multiple
          style={{ display: 'none' }}
          onChange={this.addMore}
        />

        <p style={styles.hint}>
          {'Drag thumbnails to reorder · Click to select active · ' + mediaFiles.length + ' file' + (mediaFiles.length !== 1 ? 's' : '') + ' selected'}
        </p>
      </div>
    )
  }
}

const styles = {
  container: {
    width: '100%',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    padding: '8px 0',
  },
  grid: {
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'center',
    width: '100%',
    padding: '0 8px',
    boxSizing: 'border-box',
  },
  gridItem: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    background: '#1a1a2e',
    borderRadius: 12,
    padding: '8px 8px 6px 8px',
    margin: 6,
    boxShadow: '0 4px 12px rgba(0,0,0,0.3)',
    cursor: 'pointer',
    transition: 'border-color 0.2s',
  },
  thumbnailWrap: {
    position: 'relative',
    width: 90,
    height: 90,
    borderRadius: 8,
    overflow: 'hidden',
    cursor: 'grab',
    background: '#111',
  },
  media: {
    width: '100%',
    height: '100%',
    objectFit: 'cover',
    pointerEvents: 'none',
  },
  badge: {
    position: 'absolute',
    top: 4,
    left: 4,
    background: 'rgba(108,99,255,0.9)',
    color: '#fff',
    borderRadius: '50%',
    width: 18,
    height: 18,
    fontSize: 10,
    fontWeight: 700,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 2,
    lineHeight: 1,
  },
  removeBtn: {
    position: 'absolute',
    top: 4,
    right: 4,
    background: 'rgba(231,76,60,0.88)',
    border: 'none',
    borderRadius: '50%',
    width: 20,
    height: 20,
    color: '#fff',
    fontSize: 10,
    cursor: 'pointer',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 3,
    padding: 0,
    lineHeight: 1,
  },
  dragHint: {
    position: 'absolute',
    bottom: 4,
    left: '50%',
    transform: 'translateX(-50%)',
    color: 'rgba(255,255,255,0.7)',
    fontSize: 14,
    zIndex: 2,
    cursor: 'grab',
    letterSpacing: 1,
  },
  addMore: {
    width: 106,
    height: 132,
    margin: 6,
    borderRadius: 12,
    border: '2px dashed rgba(108,99,255,0.5)',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    cursor: 'pointer',
    color: '#6c63ff',
    flexShrink: 0,
    background: 'rgba(108,99,255,0.05)',
  },
  addMoreIcon: {
    fontSize: 28,
    lineHeight: 1,
    fontWeight: 300,
  },
  addMoreLabel: {
    fontSize: 10,
    marginTop: 2,
    fontWeight: 600,
  },
  sliderContainer: {
    width: 90,
    marginTop: 8,
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  slider: {
    width: '100%',
    cursor: 'pointer',
    margin: 0,
  },
  sliderLabel: {
    fontSize: 9,
    fontWeight: 600,
    color: '#aaa',
    marginTop: 3,
  },
  hint: {
    margin: '6px 0 0',
    fontSize: 11,
    color: '#888',
    textAlign: 'center',
  },
}

const mapStateToProps = state => ({
  mediaFiles: state.Post.postIt.mediaFiles,
  activeMediaIdx: state.Post.postIt.activeMediaIdx,
})

export default connect(mapStateToProps)(MediaPreview)
