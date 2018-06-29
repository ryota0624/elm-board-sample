module Pages.CommentInput.Update exposing (..)

import Pages.CommentInput.Msg exposing (..)
import Pages.CommentInput.Model exposing (..)
import Pages.CommentInput.Ports exposing (emitStoreComment)
import Json.Encode as Encode
import Json.Decode as Decode
import Page
import Types.Id exposing (..)
import Route
update: Msg -> Model -> (Model, Cmd Msg)
update msg model = case msg of
    SetComment comment -> 
      {model | commentForm = Just comment } ! []
    SetAuthorName name  ->
      {model | commentAuthorForm = Just name } ! []
    Submit -> 
      {model | connectingApi = True} ! 
        [ model |> toJs |> Maybe.map emitStoreComment |> Maybe.withDefault Cmd.none ]
    FinishSave ->
      {model | connectingApi = False} ! [
          Route.newUrl (Route.Thread <| model.thread.id)
        ]

    PageMsg subMsg ->
      Page.update subMsg model
        |> Tuple.mapSecond (Cmd.map PageMsg)

toJs: Model -> Maybe Decode.Value
toJs model = 
  Maybe.map2 (\text -> \authorName -> 
    Encode.object [
        ("text", Encode.string text)
      , ("authorName", Encode.string authorName)
      , ("targetCommentId", 
            model.replayTarget 
              |> Maybe.map (.id >> \(CommentId id) -> Encode.string id)
              |> Maybe.withDefault (Encode.null)
        )
      , ("threadId", Encode.string <| threadIdString <| model.thread.id)
    ] 
  )
  model.commentForm
  model.commentAuthorForm