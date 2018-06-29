module Pages.ThreadsList.Update exposing (..)

import Pages.ThreadsList.Msg exposing (..)
import Pages.ThreadsList.Model exposing (..)
import Pages.ThreadsList.Ports exposing (emitStoreThread)
import Json.Encode as Encode
import Json.Decode as Decode
import Page
import Route
update: Msg -> Model -> (Model, Cmd Msg)
update msg model = case msg of
    SetThreadName name -> 
      {model | threadNameForm = Just name } ! []
    SetThreadCreatedByName name  ->
      {model | threadCreatorNameForm = Just name } ! []
    Submit -> 
      {model | connectingApi = True} ! 
        [ model |> toJs |> Maybe.map emitStoreThread |> Maybe.withDefault Cmd.none ]
    FinishSave ->
      {model | connectingApi = False} ! [
        Route.newUrl (Route.AllThread)
      ]
    PageMsg subMsg ->
      Page.update subMsg model
        |> Tuple.mapSecond (Cmd.map PageMsg)

toJs: Model -> Maybe Decode.Value
toJs model = 
  Maybe.map2 (\threadName -> \creatorName -> 
    Encode.object [
        ("name", Encode.string threadName)
      , ("creatorName", Encode.string creatorName)
    ] 
  )
  model.threadNameForm
  model.threadCreatorNameForm