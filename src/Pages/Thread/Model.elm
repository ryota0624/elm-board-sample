module Pages.Thread.Model exposing (..)

import Page
import Pages.Thread.Types.ThreadDto exposing (..)

type alias Model = Page.Model {
    thread: ThreadDto
  }

model: ThreadDto -> Model
model dto = {
    thread = dto
    , connectingApi = False
  }

