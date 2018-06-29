module Pages.CommentInput.Msg exposing (..)
import Page as Page

type Msg = 
  SetComment String
  | SetAuthorName String
  | Submit
  | PageMsg Page.Msg
  | FinishSave