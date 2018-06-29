module Decoders.Thread exposing (..)

import Json.Decode as Decode
import Types.Thread exposing (Thread)
import Types.Id exposing (ThreadId(ThreadId))

threadDecoder: Decode.Decoder Thread
threadDecoder = Decode.map3 Thread
    (Decode.field "id" (Decode.string |> Decode.map ThreadId))
    (Decode.field "name" Decode.string)
    (Decode.field "creatorName" Decode.string)