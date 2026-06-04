export default {
  fileInput: '', // file input value
  fileChanged: false, // for checking file has changed
  targetFile: '', // file (first file, kept for compat)
  previewImg: '/images/location.jpg', // preview of first file
  desc: '', // textarea value
  filter: 'filter-normal',
  fetchingLocation: false,
  location: '',
  addTag: false,
  tags: [],
  showOverlay: false,
  type: '',
  isNSFW: false,
  group: null,
  mediaFiles: [], // Array of { file, previewUrl, filter } for multi-file posts
  activeMediaIdx: 0,
}
