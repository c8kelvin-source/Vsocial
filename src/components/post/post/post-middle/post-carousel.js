import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

/**
 * PostCarousel — smooth-fading carousel for multi-media posts.
 * React 16.2 compatible (no hooks, no createRef).
 */
export default class PostCarousel extends Component {
  constructor(props) {
    super(props)
    this.state = {
      activeIdx: 0,
      visible: true,   // drives the opacity fade
      unblurNSFW: false,
    }
    this._fadeTimeout = null
  }

  componentWillUnmount() {
    if (this._fadeTimeout) clearTimeout(this._fadeTimeout)
  }

  go = (e, dir) => {
    e.preventDefault()
    e.stopPropagation()

    if (!this.state.visible) return // ignore during transition

    const { mediaFiles } = this.props

    // Fade out → swap → fade in
    this.setState({ visible: false })
    this._fadeTimeout = setTimeout(() => {
      this.setState(s => {
        let next = s.activeIdx + dir
        if (next < 0) next = mediaFiles.length - 1
        if (next >= mediaFiles.length) next = 0
        return { activeIdx: next, visible: true }
      })
    }, 220) // matches the CSS transition duration
  }

  goTo = (e, idx) => {
    e.preventDefault()
    e.stopPropagation()

    if (!this.state.visible || idx === this.state.activeIdx) return

    this.setState({ visible: false })
    this._fadeTimeout = setTimeout(() => {
      this.setState({ activeIdx: idx, visible: true })
    }, 220)
  }

  render() {
    const { mediaFiles, isNSFW, onImageClick } = this.props
    const { activeIdx, visible, unblurNSFW } = this.state
    const shouldBlur = isNSFW && !unblurNSFW
    const total = mediaFiles.length

    if (!total) return null

    const current = mediaFiles[activeIdx]
    const isVideo = current.filename && current.filename.match(/\.(mp4|webm|mov|ogg|mkv)$/i)

    const filterStr = current.filter || 'filter-normal'
    const parts = filterStr.split(' ')
    const filterClass = parts[0] || 'filter-normal'
    const contrastPart = parts.find(p => p.startsWith('contrast-'))
    const contrastVal = contrastPart ? contrastPart.replace('contrast-', '') : '100'
    const finalFilter = shouldBlur ? `contrast(${contrastVal}%) blur(20px)` : `contrast(${contrastVal}%)`

    return (
      <div style={styles.wrapper}>
        {/* ── Media area ── */}
        <div style={styles.mediaWrap}>

          {/* Fading media layer */}
          <div className={filterClass} style={{ ...styles.fadeLayer, opacity: visible ? 1 : 0 }}>
            {isVideo ? (
              <video
                key={current.filename}
                src={'/posts/' + current.filename}
                className="p_img"
                controls={!shouldBlur}
                controlsList="nodownload"
                style={{
                  ...styles.media,
                  filter: finalFilter,
                  pointerEvents: shouldBlur ? 'none' : 'auto',
                }}
              />
            ) : (
              <img
                key={current.filename}
                src={'/posts/' + current.filename}
                className="p_img"
                onClick={e => {
                  e.preventDefault()
                  if (!shouldBlur && onImageClick) onImageClick(activeIdx)
                }}
                alt={'Post media ' + (activeIdx + 1)}
                style={{
                  ...styles.media,
                  filter: finalFilter,
                  cursor: shouldBlur ? 'default' : (onImageClick ? 'pointer' : 'default'),
                }}
              />
            )}
          </div>

          {/* NSFW overlay */}
          {shouldBlur && (
            <div style={styles.nsfwOverlay}>
              <span style={styles.nsfwLabel}>Sensitive Content</span>
              <button
                type="button"
                className="sec_btn"
                onClick={e => { e.preventDefault(); this.setState({ unblurNSFW: true }) }}
                style={{ padding: '8px 15px', marginTop: 8 }}
              >
                Click to view
              </button>
            </div>
          )}

          {/* Counter badge */}
          {total > 1 && (
            <div style={styles.counter}>
              {activeIdx + 1} / {total}
            </div>
          )}

          {/* Prev / Next arrows */}
          {total > 1 && (
            <span>
              <button
                type="button"
                style={Object.assign({}, styles.arrow, styles.arrowLeft)}
                onClick={e => this.go(e, -1)}
                aria-label="Previous"
              >
                &#8249;
              </button>
              <button
                type="button"
                style={Object.assign({}, styles.arrow, styles.arrowRight)}
                onClick={e => this.go(e, 1)}
                aria-label="Next"
              >
                &#8250;
              </button>
            </span>
          )}
        </div>

        {/* ── Dot indicators ── */}
        {total > 1 && (
          <div style={styles.dots}>
            {mediaFiles.map((_, i) => (
              <span
                key={i}
                role="button"
                tabIndex={0}
                onClick={e => this.goTo(e, i)}
                style={Object.assign({}, styles.dot, {
                  background: i === activeIdx ? '#6c63ff' : 'rgba(108,99,255,0.3)',
                  transform: i === activeIdx ? 'scale(1.35)' : 'scale(1)',
                })}
              />
            ))}
          </div>
        )}
      </div>
    )
  }
}

const styles = {
  wrapper: {
    width: '100%',
    position: 'relative',
  },
  mediaWrap: {
    position: 'relative',
    width: '100%',
    height: 440, // Fixed height to prevent layout shift / page scroll jump
    overflow: 'hidden',
    background: '#111',
    borderRadius: 4,
  },
  // The fading container — transition on opacity
  fadeLayer: {
    width: '100%',
    height: '100%',
    transition: 'opacity 0.22s ease-in-out',
  },
  media: {
    width: '100%',
    height: '100%',
    display: 'block',
    objectFit: 'cover',
  },
  nsfwOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    background: 'rgba(0,0,0,0.35)',
    color: 'white',
    zIndex: 4,
  },
  nsfwLabel: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  counter: {
    position: 'absolute',
    top: 10,
    right: 12,
    background: 'rgba(0,0,0,0.55)',
    color: '#fff',
    borderRadius: 20,
    padding: '2px 10px',
    fontSize: 12,
    fontWeight: 600,
    zIndex: 3,
    letterSpacing: 0.5,
  },
  arrow: {
    position: 'absolute',
    top: '50%',
    transform: 'translateY(-50%)',
    background: 'rgba(0,0,0,0.45)',
    color: '#fff',
    border: 'none',
    borderRadius: '50%',
    width: 36,
    height: 36,
    fontSize: 26,
    cursor: 'pointer',
    zIndex: 3,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 0,
    lineHeight: '34px',
    transition: 'background 0.18s',
  },
  arrowLeft: {
    left: 8,
  },
  arrowRight: {
    right: 8,
  },
  dots: {
    display: 'flex',
    justifyContent: 'center',
    marginTop: 8,
    padding: '4px 0',
  },
  dot: {
    width: 8,
    height: 8,
    borderRadius: '50%',
    cursor: 'pointer',
    transition: 'background 0.25s, transform 0.25s',
    display: 'inline-block',
    margin: '0 4px',
  },
}

PostCarousel.propTypes = {
  mediaFiles: PropTypes.arrayOf(
    PropTypes.shape({
      filename: PropTypes.string.isRequired,
      filter: PropTypes.string,
      sort_order: PropTypes.number,
    })
  ).isRequired,
  isNSFW: PropTypes.bool,
  onImageClick: PropTypes.func,
}

PostCarousel.defaultProps = {
  isNSFW: false,
}
