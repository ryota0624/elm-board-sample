module Subscriptions exposing (subscriptions)

import Model exposing (Model, Page(..))
import Msg exposing (..)
import Ports exposing (..)
import Decoders.CommentInputModel as CommentInputModelDecoders
import Decoders.ThreadModel as ThreadModelDecoders 
import Decoders.ThreadsListModel as ThreadsListModelDecoders
import Json.Decode as Decode
import Pages.ThreadsList.Subscriptions as ThreadsListSubscriptions
import Pages.CommentInput.Subscriptions as CommentInputSubscriptions
import Page
handleResult : (a -> b) -> Result String a -> b
handleResult ifOk result  = case result of 
              Ok value -> ifOk value
              Err error -> Debug.crash error

pageSubscriptions : Page -> Sub Msg
pageSubscriptions page =
  case page of
    ThreadModel model -> Sub.none
    ThreadsListModel model -> 
      ThreadsListSubscriptions.subscriptions model |> Sub.map (ThreadsListMsg >> PageMsg)
    CommentInputModel model -> 
      CommentInputSubscriptions.subscriptions model |> Sub.map (CommentInputMsg >> PageMsg)
    Blank -> Sub.none

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [
        pageSubscriptions <| Page.getPage model.pageState
        , receiveAllThreadPageResource
            (Decode.decodeValue ThreadsListModelDecoders.threadsListModelDecoder
            >> handleResult (Msg.LoadedThreadsList >> Msg.PageLoadedMsg))
        , receiveThreadPageResource
            (Decode.decodeValue ThreadModelDecoders.threadModelDecoder
            >> handleResult (Msg.LoadedThread >> Msg.PageLoadedMsg))
        , receiveCommentInputPageResource
            (Decode.decodeValue CommentInputModelDecoders.commentInputModelDecoder
            >> handleResult (Msg.LoadedCommentInput >> Msg.PageLoadedMsg))
      ]