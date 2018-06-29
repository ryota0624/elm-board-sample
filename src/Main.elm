module Main exposing (..)

import Model exposing (Model)
import Msg exposing (Msg)
import Update exposing (update, setRoute)
import Subscriptions
import View exposing (view)
import Navigation exposing (Location)
import Route
import Navigation exposing (Location)
---- MODEL ----

init : Location -> ( Model, Cmd Msg )
init location =
    Update.setRoute (Route.fromLocation location) Model.initialModel

---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program
        (Route.fromLocation >> Msg.SetRoute)
        { view = view
        , init = init
        , update = update
        , subscriptions = Subscriptions.subscriptions
        }
