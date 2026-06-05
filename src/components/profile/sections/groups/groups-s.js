import React, { Component } from 'react'
import { FadeIn } from 'animate-components'
import Title from '../../../others/title'
import { connect } from 'react-redux'
import { bottomScroll, cLoading, Me } from '../../../../utils/utils'
import { getUserGroups } from '../../../../actions/group'
import UserGroup from './group/group'
import MonHeader from '../../../others/m-on/mon-header'
import PropTypes from 'prop-types'
import CreateGroup from '../../../group/create-group/create-group'
import Nothing from '../../../others/nothing'
import End from '../../../others/end'
import IsLoading from '../../../others/isLoading'
import classNames from 'classnames'

class UserGroups extends Component {
  state = {
    loading: true,
  }

  componentDidMount = () => {
    let { ud, dispatch } = this.props
    dispatch(getUserGroups(ud.id))
  }

  componentWillReceiveProps = ({ dispatch, ud }) => {
    this.props.ud != ud ? dispatch(getUserGroups(ud.id)) : null
    this.setState({ loading: false })
  }

  componentDidUpdate = () => bottomScroll()

  render() {
    let { loading } = this.state,
      { param: username, groups, ud } = this.props,
      len = groups.length,
      map_groups = groups.map(g => <UserGroup key={g.group_id} {...g} />),
      isMe = Me(ud.id)

    return (
      <div>
        <Title value={`@${username}'s groups`} />

        <IsLoading loading={loading} />

        <FadeIn duration="300ms" className={cLoading(loading)}>
          <div className="senapati pro_senapati">
            {isMe && (
              <div className="srajkumar" style={{ marginTop: -8 }}>
                <CreateGroup />
              </div>
            )}

            <div
              className={classNames({
                prajkumar: isMe,
                m_div: !isMe && len != 0,
                m_no_div: !isMe && len == 0,
              })}
            >
              {len == 0 ? (
                <Nothing
                  mssg={
                    isMe
                      ? "You're not a member of any group!!"
                      : `${username} is not a member of any group!!`
                  }
                />
              ) : (
                <div>
                  <MonHeader len={len} forWhat="group" />
                  <div className="m_wrapper">{map_groups}</div>
                  <End />
                </div>
              )}
            </div>
          </div>
        </FadeIn>
      </div>
    )
  }
}

UserGroups.propTypes = {
  param: PropTypes.string.isRequired,
}

const mapStateToProps = store => ({
  groups: store.Group.userGroups,
  ud: store.User.user_details,
})

export default connect(mapStateToProps)(UserGroups)
export { UserGroups as PureUserGroups }
