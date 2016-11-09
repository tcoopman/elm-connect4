module Main exposing (..)

import Html.App as App
import Connect4 exposing (newGame, view, update)


main =
    App.beginnerProgram { model = newGame, view = view, update = update }
