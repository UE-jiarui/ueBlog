mongoose = require "mongoose"
Schema = mongoose.Schema

###
Blog Schema
@type {Schema}
@date  2013.12.21
@author xuhua
###
BlogSchema = new Schema(
  title: String
  categary: String
  content: String
  author_id: Schema.ObjectId
  top:
    type: Boolean
    default: false
  reply_count:
    type: Number
    default: 0
  visit_count:
    type: Number
    default: 0
  star_count:
    tyoe: Number
    default: 0
  collect_count:
    type: Number
    default: 0
  create_at:
    type: Date
    default: Date.now
  update_at:
    type: Date
    default: Date.now
  last_reply:
    type: Schema.ObjectId
  last_reply_at:
    type: Date
    default: Date.now
)
mongoose.model "Blog", BlogSchema
