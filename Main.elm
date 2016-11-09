module Main exposing (..)

import Html.App as App
import Connect4 exposing (model, view, update)


main =
    App.beginnerProgram { model = model, view = view, update = update }
