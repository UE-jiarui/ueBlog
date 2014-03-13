mongoose = require "mongoose"
Schema = mongoose.Schema

###
Blog Schema
@type {Schema}
@date  2013.12.21
@author xuhua
###
BlogSchema = new Schema
  title: String
  categary: String
  url: String
  author_id: 
    type: Schema.Types.ObjectId
    ref: "User"
  top:
    type: Boolean
    default: false
  visit_count:
    type: Number
    default: 0
  last_visit:
    type: Schema.Types.ObjectId
    ref: "User"
  stared: [
    type: Schema.Types.ObjectId
    ref: 'User'
    ]
  collect_count:
    type: Number
    default: 0
  create_at:
    type: Date
    default: Date.now
  tags: Array
  update_at:
    type: Date
    default: Date.now
  # comments:[
    
  # ]
  last_comment:
    type: Schema.Types.ObjectId
    ref: "User"
  last_comment_at:
    type: Date
    default: Date.now

exports.Blog = mongoose.model("Blog", BlogSchema)