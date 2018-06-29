module Decoders.ThreadsListModel exposing (..)

import Json.Decode as Decode
import Pages.ThreadsList.Model exposing (..)
import Pages.ThreadsList.Types.ThreadDto exposing (..)

import Decoders.Thread as ThreadDecoder

threadsListModelDecoder : Decode.Decoder Model
threadsListModelDecoder = Decode.list (Decode.map2 threadDto
    (Decode.field "thread" ThreadDecoder.threadDecoder)
    (Decode.field "commentCount" Decode.int)
  ) |> Decode.map (model)

