module Decoders.Comment exposing (..)

import Json.Decode as Decode
import Types.Comment exposing (ReplayComment, FirstComment, firstComment, replayComment)
import Types.Id exposing (ThreadId(ThreadId), CommentId(CommentId))

firstCommentDecoder: Decode.Decoder FirstComment
firstCommentDecoder = Decode.map5 firstComment
    (Decode.field "id" (Decode.string |> Decode.map CommentId))
    (Decode.field "threadId" (Decode.string |> Decode.map ThreadId))
    (Decode.field "text" Decode.string)
    (Decode.field "authorName" Decode.string)
    (Decode.field "createdAt" Decode.float)


replayCommentDecoder: Decode.Decoder ReplayComment
replayCommentDecoder = Decode.map6 replayComment
    (Decode.field "id" (Decode.string |> Decode.map CommentId))
    (Decode.field "threadId" (Decode.string |> Decode.map ThreadId))
    (Decode.field "text" Decode.string)
    (Decode.field "authorName" Decode.string)
    (Decode.field "createdAt" Decode.float)
    (Decode.field "targetCommentId" (Decode.string |> Decode.map CommentId))
    