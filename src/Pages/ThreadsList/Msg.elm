module Pages.ThreadsList.Msg exposing (..)
import Page as Page

type Msg = 
  SetThreadName String
  | SetThreadCreatedByName String
  | Submit
  | PageMsg Page.Msg
  | FinishSave