import PostItIntialState from './postit-initial-state'

export const addPost = (posts, post) => {
  posts = [post, ...posts]
  return posts
}

export const editPost = (posts, { post_id, description }) => {
  return posts.map(p => {
    if (p.post_id == post_id) {
      p.description = description
    }
    return p
  })
}

export const deletePost = (posts, post) =>
  posts.filter(p => p.post_id != parseInt(post))

export const untag = (tags, user) => {
  let tt = tags.filter(t => t.user != user)
  return tt
}

export const unbookmark = (bookmarks, post) =>
  bookmarks.filter(b => b.post_id != post)

export const removeShare = (sharers, share_id) =>
  sharers.filter(s => s.share_id != share_id)

export const comment = (post, comment) => {
  post = {
    ...post,
    comments: [comment, ...post.comments],
  }
  return post
}

export const deleteComment = (post, comment_id) => {
  let comments = post.comments.filter(c => c.comment_id != comment_id)
  return {
    ...post,
    comments,
  }
}

export const editComment = (post, { comment_id, comment }) => {
  let comments = post.comments.map(c => {
    if (c.comment_id == comment_id) {
      c.text = comment
    }
    return c
  })

  return {
    ...post,
    comments,
  }
}

export const removeLike = (likes, like_id) =>
  likes.filter(l => l.like_id != like_id)

export const changePostIt = (postIt, pyOptions) => {
  let { what, value } = pyOptions
  let updated = {
    ...postIt,
    [what]: value,
  }

  if (what === 'filter' && Array.isArray(postIt.mediaFiles) && postIt.mediaFiles.length > 0) {
    const activeIdx = postIt.activeMediaIdx || 0
    if (postIt.mediaFiles[activeIdx]) {
      const mediaFiles = postIt.mediaFiles.slice()
      const existingFilter = mediaFiles[activeIdx].filter || 'filter-normal'
      const parts = existingFilter.split(' ')
      const contrastPart = parts.find(p => p.startsWith('contrast-'))

      mediaFiles[activeIdx].filter = contrastPart ? `${value} ${contrastPart}` : value
      updated.mediaFiles = mediaFiles
    }
  }

  return updated
}

export const resetPostItProperties = () => {
  let reset = PostItIntialState
  return reset
}
