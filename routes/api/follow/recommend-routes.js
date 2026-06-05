// ALL RECOMMENDATION-RELATED ROUTES ARE HANDLED BY THIS FILE

const app = require('express').Router(),
  db = require('../../../config/db'),
  User = require('../../../config/User')

// USERS TO RECOMMEND [REQ = USER]
app.post('/get-users-to-recommend', async (req, res) => {
  let users = await db.query(
    'SELECT follow_system.follow_id, follow_system.follow_to, follow_system.follow_to_username AS username, users.firstname, users.surname FROM follow_system, users WHERE follow_system.follow_by=? AND follow_system.follow_to = users.id AND follow_system.follow_to <> ? AND follow_system.follow_to NOT IN (SELECT recommend_to FROM recommendations WHERE recommend_by=? AND recommend_of=?) ORDER BY follow_system.follow_time DESC',
    [req.session.id, req.body.user, req.session.id, req.body.user]
  )
  res.json(users)
})

// RECOMMEND USER [REQ = USER, RECOMMEND_TO]
app.post('/recommend-user', async (req, res) => {
  let respObj = {}

  try {
    let { user, recommend_to } = req.body,
      { id: recommend_by } = req.session

    if (recommend_by === recommend_to) {
      return res.json({ mssg: 'You cannot recommend a user to yourself!!' })
    }
    if (recommend_by === user) {
      return res.json({ mssg: 'You cannot recommend yourself to others!!' })
    }

    let isBlocked = await User.isBlocked(user, recommend_by),
      isBlockedTwo = await User.isBlocked(recommend_to, recommend_by),
      recommend = {
        recommend_by,
        recommend_to,
        recommend_of: user,
        recommend_time: new Date().getTime(),
      }

    if (!isBlocked && !isBlockedTwo) {
      let username = await User.getWhat('username', user)
      let recommend_to_username = await User.getWhat('username', recommend_to)

      // Duplicate check
      let [{ count }] = await db.query(
        'SELECT COUNT(recommend_id) AS count FROM recommendations WHERE recommend_by=? AND recommend_to=? AND recommend_of=?',
        [recommend_by, recommend_to, user]
      )

      if (count > 0) {
        respObj = {
          mssg: `Already recommended ${username} to ${recommend_to_username}!!`,
        }
      } else {
        await db.query('INSERT INTO recommendations SET ?', recommend)
        respObj = {
          success: true,
          mssg: `Recommended ${username} to ${recommend_to_username}!!`,
        }
      }
    } else {
      respObj = { mssg: 'Could not recommend!!' }
    }
  } catch (error) {
    console.log(error)
    respObj = { mssg: 'An error occured!!' }
  }

  res.json(respObj)
})

// REMOVE RECOMMENDATION [REQ = RECOMMEND_ID]
app.post('/remove-recommendation', async (req, res) => {
  await db.query('DELETE FROM recommendations WHERE recommend_id=?', [
    req.body.recommend_id,
  ])
  res.json('Hello, World!!')
})

module.exports = app
