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
  url: String
  author_id: 
    type: Schema.Types.ObjectId
    ref: "User"
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
  tags: Array
  update_at:
    type: Date
    default: Date.now
  last_reply:
    type: Schema.Types.ObjectId
    ref: "User"
  last_reply_at:
    type: Date
    default: Date.now
)

# BlogSchema.virtual("articleContent").set((content) ->
#   @articleContent = password
# ).get ->
#   @articleContent

exports.Blog = mongoose.model("Blog", BlogSchema)