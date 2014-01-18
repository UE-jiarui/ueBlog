mongoose = require "mongoose"
Schema = mongoose.Schema
crypto = require "crypto"

###
User Schema
@type {Schema}
@deprecated 2013.12.21
@author xuhua
###
UserSchema = new Schema(
  name: String
  level: #0为超级管理员，1为普通用户
    type: Number
    default: 2

  gender: Number
  email:
    type: String
    unique: true

  phone: String
  username:
    type: String
    unique: true

  hashed_password: String
  create_date:
    type: Date
    default: Date.now
)

###
Virtual
@param  {String} password [description]
@return {} [description]
###
UserSchema.virtual("password").set((password) ->
  @_password = password
  @hashed_password = @encryptPassword(password)
).get ->
  @_password


###
Methods of User
@type {Object}
###
UserSchema.methods =
  
  ###
  check if the password are the same
  @param  {String} plainText
  @return {Boolean}
  ###
  authenticate: (password) ->
    console.log @hashed_password
    console.log @encryptPassword(password)
    @encryptPassword(password) is @hashed_password

  ###
  update password
  @param  {String} password
  @return {Boolean} is success
  ###
  encryptPassword: (password) ->
    crypto.createHash("md5").update(password).digest "base64"

exports.User = mongoose.model("User", UserSchema)
