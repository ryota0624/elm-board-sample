module Pages.ThreadsList.View exposing (..)

import Pages.ThreadsList.Model exposing (..)
import Pages.ThreadsList.Msg exposing (..)
import Pages.ThreadsList.Types.ThreadDto exposing (ThreadDto)
import Types.Validation as Validation 
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Event
import Helper as Helper
import Route
view: Model -> Html Msg
view model = Html.div [] [
    Validation.validationForm 
      (Helper.isAll (Nothing) [model.threadNameForm, model.threadCreatorNameForm])
      [
        threadNameForm model.threadNameForm
        , threadCreatorNameForm model.threadCreatorNameForm
      ]
      Submit,
      Html.table [] (
        model.threads |> List.map viewThreadTableLine
      )
  ]

threadNameForm: ThreadNameForm  -> (Html Msg, Maybe Validation.ValidationMessage)
threadNameForm form = 
  let
    text = form |> Maybe.withDefault ("")
    validationResults = form 
      |> Maybe.map (Validation.run [
            Validation.ifBlank "スレッド名" identity
          , Validation.ifTextIsLong "スレッド名" identity 256
        ]) 
        |> Maybe.withDefault Nothing
  in 
    (Html.input [Attr.value text, Event.onInput SetThreadName] [], validationResults)


threadCreatorNameForm: ThreadCreatorNameForm  -> (Html Msg, Maybe Validation.ValidationMessage)
threadCreatorNameForm form = 
  let
    text = form |> Maybe.withDefault ("")
    validationResults = form 
      |> Maybe.map (Validation.run [
            Validation.ifBlank "作成者名" identity
          , Validation.ifTextIsLong "作成者名" identity 32
        ]) 
        |> Maybe.withDefault Nothing  in 
    (Html.input [Attr.value text, Event.onInput SetThreadCreatedByName] [], validationResults)

viewThreadTableLine: ThreadDto -> Html Msg
viewThreadTableLine {thread, commentCount } = 
  Html.tr [] [
    Html.td  [] [ Html.a [Route.href <| Route.Thread thread.id] [Html.text thread.name] ]
    ,     Html.td  [] [Html.text thread.creatorName]
    ,    Html.td  [] [Html.text <| toString <| commentCount ]
  ]  