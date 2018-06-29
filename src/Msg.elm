module Msg exposing (..)

import Pages.ThreadsList.Msg as ThreadsListMsg
import Pages.CommentInput.Msg as CommentInputMsg
import Pages.Thread.Msg as ThreadMsg
import Route exposing (Route)
import Pages.ThreadsList.Model as ThreadsListModel
import Pages.CommentInput.Model as CommentInputModel
import Pages.Thread.Model as ThreadModel


type OnePageMsg = ThreadsListMsg ThreadsListMsg.Msg
  | CommentInputMsg CommentInputMsg.Msg
  | ThreadMsg ThreadMsg.Msg

type OnePageLoadedMsg = 
  LoadedCommentInput CommentInputModel.Model
  | LoadedThreadsList ThreadsListModel.Model
  | LoadedThread ThreadModel.Model
  

type Msg = PageMsg OnePageMsg
    | PageLoadedMsg OnePageLoadedMsg
    | SetRoute Route
