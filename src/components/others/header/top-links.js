import React, { Fragment } from 'react'
import { NavLink } from 'react-router-dom'
import { uData } from '../../../utils/utils'
import MaterialIcon from '../icons/material-icon'
import { connect } from 'react-redux'

const HeaderTopLinks = ({ unreadNotifications }) => {
  let id = uData('session')
  let username = uData('username')

  return (
    <Fragment>
      <NavLink
        to="/notifications"
        activeClassName="ha_active"
        className="notification"
        style={{ position: 'relative' }}
      >
        <span className="notification_span nav_icon">
          <MaterialIcon icon="notifications_none" />
        </span>
        {unreadNotifications > 0 && (
          <span
            style={{
              position: 'absolute',
              top: 0,
              right: 0,
              background: '#f87171', // soft vibrant red
              color: '#fff',
              borderRadius: '50%',
              minWidth: 16,
              height: 16,
              fontSize: 10,
              fontWeight: 'bold',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              padding: '0 4px',
              boxSizing: 'border-box',
              transform: 'translate(4px, -4px)',
            }}
          >
            {unreadNotifications}
          </span>
        )}
      </NavLink>

      <NavLink
        to={`/profile/${username}`}
        activeClassName="ha_active"
        className="sp"
      >
        <img src={`/users/${id}/avatar.jpg`} alt="avatar" className="sp_img" />
        <span className="sp_span">{username}</span>
      </NavLink>
    </Fragment>
  )
}

const mapStateToProps = state => ({
  unreadNotifications: state.Notification.unreadNotifications,
})

export default connect(mapStateToProps)(HeaderTopLinks)
