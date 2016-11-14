module Main exposing (..)

import Html
import Connect4 exposing (newGame, view, update)


main =
    Html.beginnerProgram { model = newGame, view = view, update = update }
