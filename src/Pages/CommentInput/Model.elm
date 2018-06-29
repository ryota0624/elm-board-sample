module Pages.CommentInput.Model exposing (..)

import Types.Thread exposing (Thread)
import Types.Comment exposing (FirstComment)
import Page

type alias CommentForm = Maybe String
type alias CommentAuthorForm = Maybe String

type alias Model = Page.Model {
    thread: Thread
    , replayTarget: Maybe FirstComment
    , commentForm : CommentForm
    , commentAuthorForm: CommentAuthorForm
  }

model: Thread ->  Maybe FirstComment ->  Model
model thread comment = {
    thread = thread
    , replayTarget = comment
    , commentForm = Nothing
    , commentAuthorForm = Nothing
    , connectingApi = False
  }