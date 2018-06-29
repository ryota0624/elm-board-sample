module Route exposing (..)
import Types.Id exposing (ThreadId(..), CommentId(..), threadIdString, commentIdString)
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), (<?>), Parser, oneOf, parsePath, s)
import Html
import Html.Attributes as Attr

type Route = AllThread
  | Thread ThreadId
  | CommentInput ThreadId (Maybe CommentId)

threadIdParser : Url.Parser (ThreadId -> a) a
threadIdParser =
    Url.custom "ThreadId" (Ok << ThreadId)

targetCommentIdQueryParser : Url.QueryParser (Maybe CommentId -> a) a
targetCommentIdQueryParser =
  Url.customParam "targetCommentId"
    (Maybe.map CommentId)

route : Parser (Route -> a) a
route =
  oneOf [
    Url.map AllThread Url.top
    , Url.map Thread (s "threads" </> threadIdParser)
    , Url.map CommentInput (s "threads" </> threadIdParser </> s "comment" <?> targetCommentIdQueryParser)
  ]

fromLocation : Location -> Route
fromLocation location =
  parsePath route location |> Maybe.withDefault AllThread

routeToString: Route -> String
routeToString route = case route of
  AllThread -> "/"
  Thread id -> "/threads/" ++ threadIdString id
  CommentInput threadId maybeCommentId -> 
    let
      paramPart = maybeCommentId
        |> Maybe.map (\commentId -> "?targetCommentId=" ++ commentIdString commentId)
        |> Maybe.withDefault ""
    in 
    "/threads/" ++ threadIdString threadId ++ "/comment"++ paramPart


href : Route -> Html.Attribute msg
href route =
    Attr.href (routeToString route)

newUrl : Route -> Cmd msg
newUrl =
    routeToString >> Navigation.newUrl
