UserModel = require("./../models/UserModel").User
CommonDao = require("CommonDao")

###
User Dao
@type {Dao}
@deprecated 2013.12.21
@author xuhua
###
UserDao = new CommonDao(UserModel)
UserDao::save = (user, callback) ->
  user = new UserModel(user)
  user.save (err, data) ->
    console.log "error in save user"  if err
    console.log "123:" + data
    callback data

module.exports = UserDao
