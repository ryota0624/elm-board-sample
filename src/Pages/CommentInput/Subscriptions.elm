module Pages.CommentInput.Subscriptions exposing (..)

import Pages.CommentInput.Msg exposing (..)
import Pages.CommentInput.Model exposing (Model)

import Pages.CommentInput.Ports exposing (receiveFinishedStoreComment)

subscriptions: Model -> Sub Msg
subscriptions model =
  Sub.batch [
    receiveFinishedStoreComment (always FinishSave)
  ]