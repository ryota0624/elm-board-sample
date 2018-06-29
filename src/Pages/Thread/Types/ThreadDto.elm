module Pages.Thread.Types.ThreadDto exposing (..)
import Types.Thread exposing (..)
import Types.Comment as Comment

type alias CommentDto = {
    firstComment: Comment.FirstComment
    , replayComments : List Comment.ReplayComment
  }
  
type alias ThreadDto = {
    thread: Thread
    , comments : List CommentDto
  }