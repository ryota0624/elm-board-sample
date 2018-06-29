module Decoders.CommentInputModel exposing (..)

import Json.Decode as Decode
import Pages.CommentInput.Model exposing (..)
import Decoders.Thread as ThreadDecoder
import Decoders.Comment as CommentDecoder

commentInputModelDecoder: Decode.Decoder Model
commentInputModelDecoder = Decode.map2 model
  (Decode.field "thread" ThreadDecoder.threadDecoder)
  (Decode.field "replayTarget" (Decode.nullable CommentDecoder.firstCommentDecoder))