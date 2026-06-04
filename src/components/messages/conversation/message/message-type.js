import React, { Component, Fragment } from 'react'
import TimeAgo from 'handy-timeago'
import ToTags from '../../../hashtag/toTags/toTags'
import PropTypes from 'prop-types'
import ImageTheatre from '../../../others/imageTheatre/imageTheatre'
import AudioPlayer from './audio-player'
import classNames from 'classnames'

export default class MessageType extends Component {
  state = {
    showImage: false,
  }

  toggleShowImage = () => this.setState({ showImage: !this.state.showImage })

  render() {
    let { type, message, message_time } = this.props.messageDetails
    let { showImage } = this.state
    const isText = type === 'text' || !type

    return (
      <Fragment>
        <div className={classNames('m_m', { 'm_m_bubble': isText })} title={TimeAgo(message_time)}>
          {!message ? (
            <span style={{ fontStyle: 'italic' }}>Empty message</span>
          ) : type == 'text' ? (
            <ToTags str={`${message}`} />
          ) : type == 'image' ? (
            <img
              src={`/messages/${message}`}
              className="m_m_img"
              onClick={this.toggleShowImage}
            />
          ) : type == 'sticker' ? (
            <img src={`/messages/${message}`} className="m_m_sticker" />
          ) : type == 'audio' ? (
            <AudioPlayer src={`/messages/${message}`} />
          ) : null}
        </div>

        {showImage && (
          <ImageTheatre
            imgSrc={`/messages/${message}`}
            showInfo={false}
            back={this.toggleShowImage}
          />
        )}
      </Fragment>
    )
  }
}

MessageType.propTypes = {
  messageDetails: PropTypes.shape({
    type: PropTypes.string.isRequired,
    message: PropTypes.string.isRequired,
    message_time: PropTypes.string.isRequired,
  }).isRequired,
}
