module Model exposing (..)

import Page
import Pages.ThreadsList.Model as ThreadsListModel
import Pages.CommentInput.Model as CommentInputModel
import Pages.Thread.Model as ThreadModel

type Page = ThreadsListModel ThreadsListModel.Model
    | CommentInputModel CommentInputModel.Model
    | ThreadModel ThreadModel.Model
    | Blank

type alias Model = {
  pageState : Page.PageState Page
  }

initialModel: Model
initialModel = {
        pageState = Page.TransitioningFrom Blank
    }  