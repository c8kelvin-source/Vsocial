import React from 'react'
import { connect } from 'react-redux'
import FileInput from '../../others/input/file'
import TextArea from '../../others/input/textArea'
import { CPP } from '../../../actions/post'
import MediaPreview from './media-preview'

const PostItMiddle = ({ postIt, session, dispatch }) => {
  let { username } = session
  let { fileChanged, desc, previewImg, filter, isNSFW, mediaFiles } = postIt

  let dp = (...args) => dispatch(CPP(...args))

  let fileChange = e => {
    // Capture everything synchronously — React 16 pools/nullifies events after
    // the handler returns, so async callbacks can't safely access e.target.
    const rawFiles = e.target.files
    if (!rawFiles || !rawFiles.length) return
    const files = Array.from(rawFiles) // copy FileList to plain array

    const readers = files.map(
      file =>
        new Promise(resolve => {
          const reader = new FileReader()
          reader.onload = ev =>
            resolve({ file, previewUrl: ev.target.result, filter: 'filter-normal' })
          reader.readAsDataURL(file)
        })
    )

    Promise.all(readers).then(entries => {
      const current = Array.isArray(mediaFiles) ? mediaFiles : []
      const updated = [...current, ...entries]
      dp('mediaFiles', updated)
      dp('fileChanged', true)
      // Sync first-file fields for backward compat (filters panel etc.)
      dp('previewImg', updated[0].previewUrl)
      dp('targetFile', updated[0].file)
      dp('filter', updated[0].filter)
    })
  }

  let valueChange = e => dp('desc', e.target.value)

  const hasFiles = fileChanged && Array.isArray(mediaFiles) && mediaFiles.length > 0

  return (
    <div className="i_p_main p_main" style={{ height: hasFiles ? 'auto' : 296, minHeight: 296, display: 'flex', flexDirection: 'column' }}>
      <div className="i_p_ta" style={{ flexShrink: 0 }}>
        <TextArea
          placeholder={`What's new with you, @${username}?`}
          value={desc}
          valueChange={valueChange}
          className="t_p_ta"
        />
      </div>

      {hasFiles ? (
        <div style={{ flexGrow: 1, overflow: 'auto', padding: '6px 0' }}>
          <MediaPreview />
        </div>
      ) : (
        <form
          className="post_img_form"
          method="post"
          encType="multipart/formdata"
          style={{ flexGrow: 1, display: 'flex', alignItems: 'center', justifyContent: 'center' }}
        >
          {/* Use a plain uncontrolled file input — React can't control file input values */}
          <label className="pri_btn" htmlFor="postit_file_input" style={{ cursor: 'pointer' }}>
            Choose images or videos
          </label>
          <input
            id="postit_file_input"
            type="file"
            accept="image/*,video/*"
            multiple
            onChange={fileChange}
            style={{ display: 'none' }}
          />
        </form>
      )}

      <div style={{ padding: '10px', display: 'flex', alignItems: 'center', justifyContent: 'flex-start', flexShrink: 0 }}>
        <input
          type="checkbox"
          id="isNSFW"
          checked={isNSFW}
          onChange={(e) => dp('isNSFW', e.target.checked)}
          style={{ marginRight: '8px', cursor: 'pointer' }}
        />
        <label htmlFor="isNSFW" style={{ cursor: 'pointer', fontSize: '13px', fontWeight: 'bold', color: '#e74c3c' }}>
          Mark as NSFW (Sensitive Content)
        </label>
      </div>
    </div>
  )
}

const mapStateToProps = state => ({
  session: state.User.session,
  postIt: state.Post.postIt,
})

export default connect(mapStateToProps)(PostItMiddle)
export { PostItMiddle as PurePostItMiddle }
