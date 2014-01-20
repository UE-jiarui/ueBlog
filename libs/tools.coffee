###
服务端通用工具方法
@date  2013.12.21
@author xuhua
###
fs = require('fs')
path = require('path')
msg = require('./msg')
config = require('./../config')

# 判断邮箱格式
checkEmail = (str) ->
	emailReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
	emailReg.test str

# 创建文件夹
mkdirArticleSync = (url, callback) ->
	articleDict = config.site.MARKDOWN_DICT
	if not fs.existsSync(articleDict)
		fs.mkdir(articleDict, 777, (err)->
			console.log('出错了') if err
			)

# 通过页码计算起始数据条数
calcStart = (pageNum) ->
	return config.site.PAGE_COUNT * (pageNum - 1)

# Buffee 操作
BufferHelper = ->
  @buffers = []
  @size = 0
  @_status = "changed"

BufferHelper::concat = (buffer) ->
  i = 0
  l = arguments.length

  while i < l
    @_concat arguments[i]
    i++
  this

BufferHelper::_concat = (buffer) ->
  @buffers.push buffer
  @size = @size + buffer.length
  @_status = "changed"
  this

BufferHelper::_toBuffer = ->
  data = null
  buffers = @buffers
  switch buffers.length
    when 0
      data = new Buffer(0)
    when 1
      data = buffers[0]
    else
      data = new Buffer(@size)
      i = 0
      pos = 0
      l = buffers.length

      while i < l
        buffer = buffers[i]
        buffer.copy data, pos
        pos += buffer.length
        i++
  
  # Cache the computed result
  @_status = "computed"
  @buffer = data
  data

BufferHelper::toBuffer = ->
  (if @_status is "computed" then @buffer else @_toBuffer())

BufferHelper::toString = ->
  Buffer::toString.apply @toBuffer(), arguments_

module.exports = 
	checkEmail: checkEmail
	mkdirArticleSync: mkdirArticleSync
	calcStart: calcStart
	BufferHelper: BufferHelper