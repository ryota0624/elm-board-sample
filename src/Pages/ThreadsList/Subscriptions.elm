module Pages.ThreadsList.Subscriptions exposing (..)

import Pages.ThreadsList.Msg exposing (..)
import Pages.ThreadsList.Model exposing (Model)

import Pages.ThreadsList.Ports exposing (receiveFinishedStoreThread)

subscriptions: Model -> Sub Msg
subscriptions model =
  Sub.batch [
    receiveFinishedStoreThread (always FinishSave)
  ]