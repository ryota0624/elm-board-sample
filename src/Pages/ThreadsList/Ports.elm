port module Pages.ThreadsList.Ports exposing (..)

import Json.Decode as Decode

port emitStoreThread: Decode.Value -> Cmd msg

port receiveFinishedStoreThread: (() -> msg) -> Sub msg
