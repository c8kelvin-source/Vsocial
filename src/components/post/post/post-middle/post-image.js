import React, { Component } from 'react'
import ToTags from '../../../hashtag/toTags/toTags'
import ImageTheatre from '../../../others/imageTheatre/imageTheatre'
import PropTypes from 'prop-types'
import PostTags from './post-tags'
import PostCarousel from './post-carousel'
import classNames from 'classnames'
import axios from 'axios'

export default class PostImage extends Component {
  state = {
    showImage: false,
    theatreIdx: 0,
    unblurNSFW: false,
    ageBlocked: false,
    ageChecking: false,
  }

  _toggle = what => this.setState({ [what]: !this.state[what] })

  render() {
    let {
      postDetails: {
        post_id,
        post_time,
        description,
        imgSrc,
        filter,
        username,
        tags_count,
        isNSFW,
        mediaFiles,
      },
    } = this.props
    let { showImage, theatreIdx, unblurNSFW } = this.state

    // Resolve media list: prefer mediaFiles array, fall back to single imgSrc
    const media = Array.isArray(mediaFiles) && mediaFiles.length > 0
      ? mediaFiles
      : (imgSrc ? [{ filename: imgSrc, filter: filter || 'filter-normal', sort_order: 0 }] : [])

    const isMulti = media.length > 1
    const shouldBlur = isNSFW && !unblurNSFW

    return (
      <div>
        <div className="p_o">
          <div className="p_actual" spellCheck="false">
            <div
              className="p_abt"
              style={{ marginBottom: description ? '10px' : null }}
            >
              <p>
                <ToTags str={`${description}`} />
              </p>
            </div>

            {/* Multi-file carousel */}
            {isMulti ? (
              <PostCarousel
                mediaFiles={media}
                isNSFW={isNSFW}
                onImageClick={idx => this.setState({ showImage: true, theatreIdx: idx })}
              />
            ) : media.length === 1 ? (
              /* Single file — original behaviour */
              (() => {
                const item = media[0]
                const filterStr = item.filter || 'filter-normal'
                const parts = filterStr.split(' ')
                const filterClass = parts[0] || 'filter-normal'
                const contrastPart = parts.find(p => p.startsWith('contrast-'))
                const contrastVal = contrastPart ? contrastPart.replace('contrast-', '') : '100'
                const finalFilter = shouldBlur ? `contrast(${contrastVal}%) blur(20px)` : `contrast(${contrastVal}%)`

                return (
                  <div style={{ position: 'relative' }} className={filterClass}>
                    {item.filename.match(/\.(mp4|webm|mov|ogg|mkv)$/i) ? (
                      <video
                        src={`/posts/${item.filename}`}
                        className="p_img"
                        controls={!shouldBlur}
                        controlsList="nodownload"
                        style={{ filter: finalFilter, pointerEvents: shouldBlur ? 'none' : 'auto' }}
                      />
                    ) : (
                      <img
                        src={`/posts/${item.filename}`}
                        className="p_img"
                        onClick={() => { if (!shouldBlur) this.setState({ showImage: true, theatreIdx: 0 }) }}
                        style={{ filter: finalFilter, cursor: shouldBlur ? 'default' : 'pointer' }}
                        alt="Post"
                      />
                    )}
                    {shouldBlur && (
                      <div style={{ position: 'absolute', top: 0, left: 0, width: '100%', height: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', background: 'rgba(0,0,0,0.3)', color: 'white', zIndex: 2 }}>
                        <span style={{ fontSize: '18px', fontWeight: 'bold', marginBottom: '10px' }}>Sensitive Content</span>
                        {this.state.ageBlocked ? (
                          <span style={{ fontSize: '13px', color: '#ffb3b3', padding: '6px 12px', background: 'rgba(255,0,0,0.25)', borderRadius: '6px', textAlign: 'center', maxWidth: '200px' }}>
                            🔞 Age-restricted: You must be 18+ to view this content.
                          </span>
                        ) : (
                          <button
                            className="sec_btn"
                            disabled={this.state.ageChecking}
                            onClick={async () => {
                              this.setState({ ageChecking: true })
                              try {
                                const { data } = await axios.post('/api/check-nsfw-access')
                                if (data.allowed) {
                                  this.setState({ unblurNSFW: true, ageChecking: false })
                                } else {
                                  this.setState({ ageBlocked: true, ageChecking: false })
                                }
                              } catch (e) {
                                this.setState({ ageChecking: false })
                              }
                            }}
                            style={{ padding: '8px 15px' }}
                          >
                            {this.state.ageChecking ? 'Checking…' : 'Click to view'}
                          </button>
                        )}
                      </div>
                    )}
                  </div>
                )
              })()
            ) : null}

            <PostTags post_id={post_id} tags_count={tags_count} />
          </div>
        </div>

        {showImage && media[theatreIdx] && !media[theatreIdx].filename.match(/\.(mp4|webm|mov|ogg|mkv)$/i) && (
          <ImageTheatre
            imgSrc={`/posts/${media[theatreIdx].filename}`}
            filter={media[theatreIdx].filter}
            username={username}
            time={post_time}
            link={`/post/${post_id}`}
            back={() => this._toggle('showImage')}
          />
        )}
      </div>
    )
  }
}

PostImage.propTypes = {
  postDetails: PropTypes.shape({
    post_id: PropTypes.number.isRequired,
    post_time: PropTypes.string.isRequired,
    description: PropTypes.string.isRequired,
    imgSrc: PropTypes.string.isRequired,
    filter: PropTypes.string.isRequired,
    tags_count: PropTypes.number.isRequired,
    username: PropTypes.string.isRequired,
    isNSFW: PropTypes.bool,
    mediaFiles: PropTypes.array,
  }).isRequired,
}
