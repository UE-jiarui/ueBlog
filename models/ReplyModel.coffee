# mongoose = require "mongoose"
# Schema = mongoose.Schema

# # 博客评论回复
# ReplySchema = new Schema(
# 	author_id: 
#     type: Schema.Types.ObjectId
#     ref: "User"
#   create_at:
#   	type: Date
#     default: Date.now
#   content: String
#   blog_id:
#   	type: Schema.Types.ObjectId
#   	ref: "Blog"
#   reply_to:
#   	type: Schema.Types.ObjectId
#   	ref: "Reply"
# )

# exports.Reply = mongoose.model("Reply", ReplySchema)
