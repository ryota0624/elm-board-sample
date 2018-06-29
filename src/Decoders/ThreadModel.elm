module Decoders.ThreadModel exposing (..)

import Json.Decode as Decode
import Pages.Thread.Model exposing (..)
import Pages.Thread.Types.ThreadDto exposing (..)
import Decoders.Comment as CommentDecoder
import Decoders.Thread as ThreadDecoder

commentDtoDecoder : Decode.Decoder CommentDto
commentDtoDecoder = Decode.map2 CommentDto
  (Decode.field "firstComment" CommentDecoder.firstCommentDecoder)
  (Decode.field "replayComments" (Decode.list CommentDecoder.replayCommentDecoder))

threadModelDecoder : Decode.Decoder Model
threadModelDecoder = Decode.map2 ThreadDto 
  (Decode.field "thread" ThreadDecoder.threadDecoder)
  (Decode.field "comments" (Decode.list commentDtoDecoder))
  |> Decode.map model
