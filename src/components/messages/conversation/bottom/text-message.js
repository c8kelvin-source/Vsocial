import React, { Component, Fragment } from 'react'
import { textMessage, audioMessage, imageMessage, stickerMessage } from '../../../../utils/message-utils'
import { connect } from 'react-redux'
import ConversationAddEmojis from './add-emojis'
import TextArea from '../../../others/input/textArea'
import { t } from '../../../../utils/translation'
import MaterialIcon from '../../../others/icons/material-icon'
import Notify from 'handy-notification'
import Stickers from '../../../others/stickers/stickers'

class TextMessage extends Component {
  state = {
    messageValue: '',
    isRecording: false,
    recordingSeconds: 0,
    showStickers: false,
  }

  changeMssgValue = e => this.setState({ messageValue: e.target.value })

  message = e => {
    e.preventDefault()
    let { messageValue } = this.state
    let {
      cd: { con_id, con_with },
      dispatch,
    } = this.props
    if (!messageValue.trim()) return
    textMessage({
      message: messageValue,
      con_id,
      con_with,
      dispatch,
    })
    this.setState({ messageValue: '' })
  }

  startRecording = async () => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
      this.mediaRecorder = new MediaRecorder(stream)
      this.audioChunks = []
      this.shouldSend = false

      this.mediaRecorder.ondataavailable = e => {
        if (e.data.size > 0) {
          this.audioChunks.push(e.data)
        }
      }

      this.mediaRecorder.onstop = () => {
        stream.getTracks().forEach(track => track.stop())
        if (this.shouldSend) {
          const audioBlob = new Blob(this.audioChunks, { type: 'audio/webm' })
          let {
            cd: { con_id, con_with },
            dispatch,
          } = this.props
          audioMessage({
            file: audioBlob,
            con_id,
            con_with,
            dispatch,
          })
        }
        this.audioChunks = []
      }

      this.mediaRecorder.start()
      this.setState({ isRecording: true, recordingSeconds: 0 })

      this.timer = setInterval(() => {
        this.setState(prevState => ({
          recordingSeconds: prevState.recordingSeconds + 1,
        }))
      }, 1000)
    } catch (err) {
      Notify({ value: 'Microphone access denied or not supported!' })
    }
  }

  cancelRecording = () => {
    this.shouldSend = false
    if (this.mediaRecorder && this.mediaRecorder.state !== 'inactive') {
      this.mediaRecorder.stop()
    }
    clearInterval(this.timer)
    this.setState({ isRecording: false, recordingSeconds: 0 })
  }

  stopAndSendRecording = () => {
    this.shouldSend = true
    if (this.mediaRecorder && this.mediaRecorder.state !== 'inactive') {
      this.mediaRecorder.stop()
    }
    clearInterval(this.timer)
    this.setState({ isRecording: false, recordingSeconds: 0 })
  }

  formatTime = seconds => {
    const mins = Math.floor(seconds / 60)
    const secs = seconds % 60
    return `${mins < 10 ? '0' : ''}${mins}:${secs < 10 ? '0' : ''}${secs}`
  }

  handleImageUpload = e => {
    const {
      cd: { con_id, con_with },
      dispatch,
    } = this.props
    if (e.target.files.length > 0) {
      imageMessage({
        con_id,
        con_with,
        file: e.target.files[0],
        dispatch,
      })
    }
    e.target.value = ''
  }

  toggleStickers = () => {
    this.setState({ showStickers: !this.state.showStickers })
  }

  handleStickerSelect = sticker => {
    let {
      cd: { con_id, con_with },
      dispatch,
    } = this.props
    stickerMessage({ con_id, con_with, sticker, dispatch })
    this.setState({ showStickers: false })
  }

  componentWillUnmount = () => {
    if (this.timer) {
      clearInterval(this.timer)
    }
    if (this.mediaRecorder && this.mediaRecorder.state !== 'inactive') {
      this.mediaRecorder.stop()
    }
  }

  render() {
    let { messageValue, isRecording, recordingSeconds, showStickers } = this.state
    let { lang } = this.props
    const hasText = messageValue.trim().length > 0

    return (
      <Fragment>
        {isRecording ? (
          <div className="mssg_recording_container">
            <span className="mssg_recording_dot"></span>
            <span className="mssg_recording_timer">{this.formatTime(recordingSeconds)}</span>
            <button type="button" className="mssg_recording_cancel" onClick={this.cancelRecording}>
              <MaterialIcon icon="delete" />
            </button>
            <button type="button" className="mssg_recording_send" onClick={this.stopAndSendRecording}>
              <MaterialIcon icon="send" />
            </button>
          </div>
        ) : (
          <form className="add_mssg_form" onSubmit={this.message}>
            <div className="mssg_input_wrapper" style={{ position: 'relative', width: '100%', display: 'flex' }}>
              <TextArea
                placeholder={t(lang, 'messages', 'sendMessage')}
                className="send_mssg"
                required
                value={messageValue}
                valueChange={this.changeMssgValue}
                style={{
                  paddingRight: hasText ? '75px' : '145px',
                  paddingLeft: '15px', // Reset left padding since emoji is on the right now
                  width: '100%'
                }}
              />
              <div className="mssg_input_actions">
                <ConversationAddEmojis
                  updateMssgValue={value => this.setState({ messageValue: value })}
                />
                {hasText ? (
                  <button type="submit" className="mssg_send_btn" data-tip="Send message">
                    <MaterialIcon icon="send" />
                  </button>
                ) : (
                  <Fragment>
                    <span className="mssg_action_btn mssg_mic_btn" onClick={this.startRecording} data-tip="Record voice message">
                      <MaterialIcon icon="mic" />
                    </span>
                    <span className="mssg_action_btn mssg_img_btn" data-tip="Send image">
                      <input
                        type="file"
                        id="msg_image_upload"
                        accept="image/*"
                        style={{ display: 'none' }}
                        onChange={this.handleImageUpload}
                      />
                      <label htmlFor="msg_image_upload" style={{ cursor: 'pointer', display: 'flex', margin: 0 }}>
                        <MaterialIcon icon="image" />
                      </label>
                    </span>
                    <span className="mssg_action_btn mssg_sticker_btn" onClick={this.toggleStickers} data-tip="Send sticker">
                      <MaterialIcon icon="insert_emoticon" />
                    </span>
                  </Fragment>
                )}
              </div>
            </div>
          </form>
        )}

        {showStickers && (
          <Stickers
            back={() => this.setState({ showStickers: false })}
            stickerSelected={this.handleStickerSelect}
          />
        )}
      </Fragment>
    )
  }
}

const mapStateToProps = store => ({
  cd: store.Message.conDetails,
  lang: store.Language.language
})

export default connect(mapStateToProps)(TextMessage)
export { TextMessage as PureTextMessage }
