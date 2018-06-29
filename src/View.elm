module View exposing (view)

import Model exposing (Model)
import Html exposing (Html)
import Msg exposing (Msg)
import Html.Attributes as Attr
import Page exposing (PageState(Loaded, TransitioningFrom))
import Pages.ThreadsList.View as ThreadsListView
import Pages.Thread.View as ThreadView 
import Pages.CommentInput.View as CommentInputView


view: Model -> Html Msg
view model = 
  case model.pageState of
    Loaded page -> viewPage model False page
    TransitioningFrom page -> viewPage model True page

pageMsg : Msg.OnePageMsg -> Msg
pageMsg = Msg.PageMsg

viewPage : Model -> Bool -> Model.Page -> Html Msg    
viewPage model isLoading page =
  Html.div [] [
    case page of
      Model.Blank -> 
        Html.div [] [Html.text "Blank"]
      Model.CommentInputModel subModel -> 
        CommentInputView.view subModel |> Html.map (Msg.CommentInputMsg >> pageMsg)
      Model.ThreadModel subModel -> 
        ThreadView.view subModel |> Html.map (Msg.ThreadMsg >> pageMsg)
      Model.ThreadsListModel subModel -> 
        ThreadsListView.view subModel |> Html.map (Msg.ThreadsListMsg >> pageMsg)
    , if isLoading then viewLoadingOverRay else Html.text ""    
    ]



viewLoadingOverRay : Html.Html msg
viewLoadingOverRay =
    Html.div [ Attr.class "loading-over-ray" ]
        [ Html.div [ Attr.class "loading-circle" ] []
        ]


