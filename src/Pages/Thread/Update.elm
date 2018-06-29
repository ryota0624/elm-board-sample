module Pages.Thread.Update exposing (update)

import Page
import Pages.Thread.Model exposing (Model)
import Pages.Thread.Msg exposing (..)

update : Msg -> Model -> (Model, Cmd Msg )
update msg model = 
  case msg of
    PageMsg subMsg -> Page.update subMsg model |> Tuple.mapSecond (Cmd.map PageMsg)    