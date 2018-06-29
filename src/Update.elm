module Update exposing (update, setRoute)

import Msg exposing (..)
import Model exposing (..)

import Page
import Route

import Pages.ThreadsList.Update as ThreadsListUpdate
import Pages.CommentInput.Update as CommentInputUpdate
import Pages.Thread.Update as ThreadUpdate
import Ports
import Types.Id exposing (..)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    PageMsg pageMsg -> handlePageMsg pageMsg model 
      |> Tuple.mapSecond (Cmd.map PageMsg)
    PageLoadedMsg loadedMsg -> 
      handlePageLoaded loadedMsg model
    SetRoute route ->
      setRoute route model

setRoute: Route.Route -> Model -> (Model, Cmd Msg)
setRoute route model =
  case route of
    Route.AllThread -> model ! [
        Ports.emitRequestAllThreadPageResource ()
      ]
    Route.Thread threadId -> model ! [
        Ports.emitRequestThreadPageResource <| threadIdString <| threadId
      ]
    Route.CommentInput threadId maybeCommentId -> model ! [
        Ports.emitRequestCommentInputPageResource {
            threadId = threadIdString <| threadId
            , commentId = maybeCommentId |> Maybe.map commentIdString
          }
      ]
    
  
handlePageMsg: OnePageMsg -> Model -> (Model, Cmd OnePageMsg)
handlePageMsg msg model =
  let
    toPage = Page.toPage model 
  in 
  case (msg, Page.getPage model.pageState) of
    (ThreadsListMsg subMsg, ThreadsListModel subModel) -> toPage ThreadsListModel ThreadsListMsg ThreadsListUpdate.update  subMsg subModel
    (CommentInputMsg subMsg, CommentInputModel subModel) -> toPage CommentInputModel CommentInputMsg CommentInputUpdate.update subMsg subModel
    (ThreadMsg subMsg, ThreadModel subModel) -> toPage ThreadModel ThreadMsg ThreadUpdate.update subMsg subModel
    _ -> model ! []

-- handleSetRoute: Route -> Model -> (Model, Cmd Msg )

handlePageLoaded : OnePageLoadedMsg -> Model -> (Model, Cmd Msg)
handlePageLoaded msg model = case msg of
  LoadedCommentInput subModel -> {model | pageState = Page.Loaded <| CommentInputModel subModel} ! []
  LoadedThread subModel -> {model | pageState = Page.Loaded <| ThreadModel subModel} ! []
  LoadedThreadsList subModel -> {model | pageState = Page.Loaded <| ThreadsListModel subModel} ! []