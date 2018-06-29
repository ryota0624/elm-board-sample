module Types.Comment exposing (..)
import Types.Id exposing (CommentId, ThreadId)
import Date

type alias Comment field= { field | 
  id: CommentId
  , threadId : ThreadId
  , text: String
  , authorName: String
  , createdAt: Date.Date
   }

type alias FirstComment = Comment {}

firstComment: CommentId -> ThreadId -> String -> String -> Float -> FirstComment
firstComment commentId threadId text authorName createdAtTime = {
    id = commentId
    , threadId = threadId
    , text = text
    , authorName = authorName
    , createdAt = Date.fromTime createdAtTime
  }

type alias ReplayComment = Comment { targetCommentId : CommentId }

replayComment: CommentId -> ThreadId -> String -> String -> Float -> CommentId -> ReplayComment
replayComment commentId threadId text authorName createdAtTime targetCommentId = {
    id = commentId
    , threadId = threadId
    , text = text
    , authorName = authorName
    , createdAt = Date.fromTime createdAtTime
    , targetCommentId = targetCommentId
  }

-- type Comment = F FirstComment
--   | R ReplayComment

-- id: Comment -> CommentId
-- id comment = case comment of
--   F {id} -> id
--   R {id} -> id 

-- text: Comment -> String
-- text comment = case comment of
--   F {text} -> text
--   R {text} -> text 

-- creatorName: Comment -> String
-- creatorName comment = case comment of
--   F {creatorName} -> creatorName
--   R {creatorName} -> creatorName


-- targetCommentId : Comment -> Maybe CommentId
-- targetCommentId comment = case comment of
--   F _ -> Nothing
--   R {targetCommentId} -> Just targetCommentId