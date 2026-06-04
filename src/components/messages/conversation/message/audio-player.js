import React, { Component } from 'react'
import PropTypes from 'prop-types'
import MaterialIcon from '../../../others/icons/material-icon'

export default class AudioPlayer extends Component {
  state = {
    playing: false,
    duration: 0,
    currentTime: 0,
  }

  audio = null

  componentDidMount() {
    this.audio = new Audio(this.props.src)
    
    this.audio.addEventListener('loadedmetadata', this.onLoadedMetadata)
    this.audio.addEventListener('timeupdate', this.onTimeUpdate)
    this.audio.addEventListener('ended', this.onEnded)
  }

  componentWillUnmount() {
    if (this.audio) {
      this.audio.pause()
      this.audio.removeEventListener('loadedmetadata', this.onLoadedMetadata)
      this.audio.removeEventListener('timeupdate', this.onTimeUpdate)
      this.audio.removeEventListener('ended', this.onEnded)
    }
  }

  onLoadedMetadata = () => {
    this.setState({ duration: this.audio.duration })
  }

  onTimeUpdate = () => {
    this.setState({ currentTime: this.audio.currentTime })
  }

  onEnded = () => {
    this.setState({ playing: false, currentTime: 0 })
  }

  togglePlay = () => {
    if (this.state.playing) {
      this.audio.pause()
      this.setState({ playing: false })
    } else {
      this.audio.play()
      this.setState({ playing: true })
    }
  }

  onSeek = e => {
    const time = parseFloat(e.target.value)
    this.audio.currentTime = time
    this.setState({ currentTime: time })
  }

  formatTime = seconds => {
    if (isNaN(seconds)) return '00:00'
    const mins = Math.floor(seconds / 60)
    const secs = Math.floor(seconds % 60)
    return `${mins < 10 ? '0' : ''}${mins}:${secs < 10 ? '0' : ''}${secs}`
  }

  render() {
    const { playing, duration, currentTime } = this.state
    const progressPercent = duration > 0 ? (currentTime / duration) * 100 : 0

    return (
      <div className="custom_audio_player">
        <button type="button" className="play_pause_btn" onClick={this.togglePlay}>
          <MaterialIcon icon={playing ? 'pause' : 'play_arrow'} />
        </button>
        
        <div className="audio_progress_container">
          <input
            type="range"
            min={0}
            max={duration || 100}
            value={currentTime}
            onChange={this.onSeek}
            className="audio_seek_bar"
            style={{
              background: `linear-gradient(to right, currentColor ${progressPercent}%, rgba(255, 255, 255, 0.2) ${progressPercent}%)`
            }}
          />
        </div>

        <span className="audio_time_label">
          {this.formatTime(currentTime)} / {this.formatTime(duration)}
        </span>
      </div>
    )
  }
}

AudioPlayer.propTypes = {
  src: PropTypes.string.isRequired,
}
