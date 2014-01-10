mongoose = require("mongoose")
User = require("./../models/UserModel").User
log = require("./../libs/log")
msg = require("./../libs/msg")
tools = require("./../libs/tools")

# 注册
exports.create = (req, res) ->
  newUser = new User(req.body)
  User.findOne
    username: newUser.username
  , (err, user) ->
    return res.json err: err  if err
    return res.json err: msg.USER.userNameExist  if user
    newUser.save (err, curUser) ->
      return res.json err: err  if err
      req.session["user"] = curUser
      res.json success: msg.MAIN.success

# 登录
exports.login = (req, res) ->
  loginUser = new User(req.body)
  # 邮箱登录
  if tools.checkEmail(loginUser.username)
    User.findOne
      email: loginUser.username
    , (err, user) ->
      return res.json err: err if err
      return res.json err: msg.USER.userEmailNone  unless user
      return res.json err: msg.USER.userWrongPwd  unless user.authenticate(loginUser.password)
      req.session["user"] = user
      res.json user
  # 用户名登录
  else
    User.findOne
      username: loginUser.username
    , (err, user) ->
      return res.json err: err  if err
      unless user
        return res.json err: msg.USER.userNameNone
      return res.json err: msg.USER.userWrongPwd  unless user.authenticate(loginUser.password)
      req.session["user"] = user
      res.json user

# 注销
exports.logout = (req, res) ->
  req.session.destroy();
  res.json success: msg.MAIN.success

# 获取登录信息
exports.getLoginUser = (req, res) ->
  res.json req.session["user"] or {}
