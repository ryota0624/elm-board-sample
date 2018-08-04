module Types.Comment exposing (..)
import Types.Id exposing (CommentId, ThreadId)
import Date

type alias CommentAttribute = {
  id: CommentId
  , threadId : ThreadId
  , text: String
  , authorName: String
  , createdAt: Date.Date
   }

type alias ReplayCommentAttiriute = {
  targetCommentId: CommentId
  }

type Comment = First CommentAttribute
  | Replay CommentAttribute ReplayCommentAttiriute

firstComment: CommentId -> ThreadId -> String -> String -> Float -> Comment
firstComment commentId threadId text authorName createdAtTime = {
    id = commentId
    , threadId = threadId
    , text = text
    , authorName = authorName
    , createdAt = Date.fromTime createdAtTime
  } |> First

replayComment: CommentId -> ThreadId -> String -> String -> Float -> CommentId -> Comment
replayComment commentId threadId text authorName createdAtTime targetCommentId = 
  Replay
    {
      id = commentId
      , threadId = threadId
      , text = text
      , authorName = authorName
      , createdAt = Date.fromTime createdAtTime
    }
    {
      targetCommentId = targetCommentId
    }