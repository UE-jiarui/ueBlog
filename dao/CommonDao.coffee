###
公共Dao
@date 2013.12.21
@author xuhua
@link url: http://www.oschina.net/code/snippet_698737_17103
###
CommonDao = (Model) ->
  @model = Model

###
create
主要用于批量添加
###
CommonDao::create = (doc, callback) ->
  @model.create doc, (error) ->
    return callback(error)  if error
    callback null

###
根据Id获取Model
###
CommonDao::getById = (id, callback) ->
  @model.findOne
    _id: id
  , (error, model) ->
    return callback(error, null)  if error
    callback null, model

###
根据查询条件获取Model
###
CommonDao::countByQuery = (query, callback) ->
  @model.count query, (error, model) ->
    return callback(error, null)  if error
    callback null, model

###
根据查询条件获取Model
###
CommonDao::getByQuery = (query, fileds, opt, callback) ->
  @model.find query, fileds, opt, (error, model) ->
    return callback(error, null)  if error
    callback null, model

###
获取所有Model
###
CommonDao::getAll = (callback) ->
  @model.find {}, (error, model) ->
    return callback(error, null)  if error
    callback null, model

###
根据查询条件删除
###
CommonDao::delete = (query, callback) ->
	@model.remove query, (error) ->
    return callback(error)  if error
    callback null

###
更新
###
CommonDao::update = (conditions, update, options, callback) ->
  @model.update conditions, update, options, (error) ->
    return callback(error)  if error
    callback null

module.exports = CommonDao
