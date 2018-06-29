port module Pages.CommentInput.Ports exposing (..)

import Json.Decode as Decode

port emitStoreComment: Decode.Value -> Cmd msg

port receiveFinishedStoreComment: (() -> msg) -> Sub msg
