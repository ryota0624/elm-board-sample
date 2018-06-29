module Pages.CommentInput.View exposing (view)

import Html exposing (Html)
import Pages.CommentInput.Model exposing (..)
import Pages.CommentInput.Msg exposing (..)
import Html.Attributes as Attr
import Html.Events as Event
import Helper as Helper
import Types.Validation as Validation 
import Route
view: Model -> Html Msg
view model = Html.div [] [
    Html.a [Route.href <| Route.Thread model.thread.id] [Html.text "スレッド詳細へもどる"]
    ,Validation.validationForm 
      (Helper.isAll (Nothing) [model.commentForm, model.commentAuthorForm])
      [
        commentForm model.commentForm
        , commentAuthorForm model.commentAuthorForm
      ]
      Submit
  ]


commentForm: CommentForm  -> (Html Msg, Maybe Validation.ValidationMessage)
commentForm form = 
  let
    text = form |> Maybe.withDefault ("")
    validationResults = form 
      |> Maybe.map (Validation.run [
            Validation.ifBlank "コメント" identity
          , Validation.ifTextIsShort "コメント" identity 5
        ]) 
        |> Maybe.withDefault Nothing
  in 
    (Html.input [Attr.value text, Event.onInput SetComment] [], validationResults)


commentAuthorForm: CommentAuthorForm  -> (Html Msg, Maybe Validation.ValidationMessage)
commentAuthorForm form = 
  let
    text = form |> Maybe.withDefault ("")
    validationResults = form 
      |> Maybe.map (Validation.run [
            Validation.ifBlank "なまえ" identity
          , Validation.ifTextIsLong "なまえ" identity 32
        ]) 
        |> Maybe.withDefault Nothing  in 
    (Html.input [Attr.value text, Event.onInput SetAuthorName] [], validationResults)
