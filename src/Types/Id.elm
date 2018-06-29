module Types.Id exposing (..)

type ThreadId = ThreadId String
type CommentId = CommentId String


threadIdString : ThreadId -> String
threadIdString (ThreadId value) = value

commentIdString : CommentId -> String
commentIdString (CommentId value) = value