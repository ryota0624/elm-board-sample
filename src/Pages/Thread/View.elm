module Pages.Thread.View exposing (view)

import Pages.Thread.Model exposing (Model)
import Pages.Thread.Msg exposing (Msg)
import Pages.Thread.Types.ThreadDto exposing (..)
import Html exposing (Html)
import Types.Comment exposing (..)
import Route
import Types.Id exposing (ThreadId)
view : Model -> Html Msg
view {thread} = Html.div [] ([
    Html.div [] [Html.text <| toString <| thread]
    , Html.a [Route.href <| Route.AllThread] [Html.text "一覧"]
    , Html.a [
        Route.href <| Route.CommentInput thread.thread.id Nothing
      ] [Html.text "コメント"]
  ] ++ 
    (thread.comments |> List.map (viewComment thread.thread.id))
  )


viewComment: ThreadId -> CommentDto -> Html Msg
viewComment threadId  {firstComment, replayComments} = Html.div [] [
    Html.div [] [
        Html.div [] [Html.text <| firstComment.authorName]
        , Html.div [] [ Html.text <| firstComment.text, Html.text <| toString firstComment.createdAt ]
        , Html.a [
            Route.href <| Route.CommentInput threadId (Just firstComment.id)
          ] [Html.text "コメント"]
        , Html.ul [] (
          replayComments |> List.map viewReplayComment
        )
    ]
  ]

viewReplayComment: ReplayComment -> Html Msg
viewReplayComment replayComment = Html.div [] [
          Html.text <| replayComment.authorName
        , Html.text <| replayComment.text
  ]
