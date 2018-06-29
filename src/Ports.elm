port module Ports exposing (..)

import Json.Decode as Decode

type alias ThreadId = String

type alias CommentId = String

port emitRequestAllThreadPageResource: () -> Cmd msg

port emitRequestThreadPageResource: (ThreadId) -> Cmd msg

port emitRequestCommentInputPageResource: ({threadId: ThreadId, commentId: Maybe CommentId}) -> Cmd msg

port receiveAllThreadPageResource: (Decode.Value -> msg) -> Sub msg

port receiveThreadPageResource: (Decode.Value -> msg) -> Sub msg

port receiveCommentInputPageResource: (Decode.Value -> msg) -> Sub msg
