UserModel = require("./../models/UserModel").User

###
User Dao
@type {Dao}
@deprecated 2013.12.21
@author xuhua
###
UserDao = 
	model: UserModel
	save: (user, callback) ->
	  user = new UserModel(user)
	  user.save (err, data) ->
	    console.log "error in save user"  if err
	    callback data

module.exports = UserDao
