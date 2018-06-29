module Pages.ThreadsList.Model exposing (..)

import Pages.ThreadsList.Types.ThreadDto exposing (ThreadDto)
import Types.Thread exposing (Thread)
import Page

type alias ThreadNameForm = Maybe String
type alias ThreadCreatorNameForm = Maybe String

type alias Model = Page.Model {
    threads: List ThreadDto
    , threadNameForm : ThreadNameForm
    , threadCreatorNameForm: ThreadCreatorNameForm
  }

model: List ThreadDto ->  Model
model dtos = {
    threads = dtos
    , threadNameForm = Nothing
    , threadCreatorNameForm = Nothing
    , connectingApi = False
  }