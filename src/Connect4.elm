module Connect4 exposing (newGame, view, update, Msg(..))

import Dict exposing (Dict)
import Html exposing (Html, button, div, text)
import Svg exposing (Svg, circle, svg, line)
import Svg.Attributes exposing (width, height, viewBox, cx, cy, r, fill, x1, x2, y1, y2, stroke, strokeWidth)
import Svg.Events exposing (onClick)
import List


type Player
    = PlayerRed
    | PlayerBlue


type Disc
    = Red
    | Blue


type alias Row =
    Int


type alias Column =
    Int


type Board
    = Board Row Column


type alias Position =
    ( Row, Column )


type alias Game =
    { currentColor : Disc
    , board : Board
    , gameState : Dict Position Disc
    }


newGame =
    { currentColor = Red
    , board = Board 6 7
    , gameState = Dict.empty
    }


type Msg
    = InsertDisc Column


heightOfColumn : Dict Position Disc -> Column -> Int
heightOfColumn gameState col =
    Dict.keys gameState
        |> List.filter ((==) col << snd)
        |> List.map fst
        |> List.maximum
        |> Maybe.withDefault 0


update : Msg -> Game -> Game
update msg game =
    case msg of
        InsertDisc col ->
            let
                newRow =
                    (heightOfColumn game.gameState col) + 1

                newGameState =
                    Dict.insert ( newRow, col ) game.currentColor game.gameState

                newColor =
                    case game.currentColor of
                        Red ->
                            Blue

                        Blue ->
                            Red
            in
                case game.board of
                    Board _ row ->
                        if newRow >= row then
                            game
                        else
                            { game | gameState = newGameState, currentColor = newColor }


view : Game -> Html Msg
view model =
    div []
        [ svg [ width "700", height "700", viewBox "0 0 700 700" ]
            (drawDiscs model.gameState
                ++ drawEmptyBoard model.board
                ++ drawColumnInserts model
            )
        , div [] [ text (toString model) ]
        ]


drawDiscs : Dict Position Disc -> List (Svg msg)
drawDiscs dict =
    let
        drawDisc ( row, column ) disc result =
            let
                xValue =
                    -50 + (column * 100) |> toString

                yValue =
                    50 + (600 - row * 100) |> toString

                color =
                    case disc of
                        Red ->
                            "red"

                        Blue ->
                            "blue"
            in
                (circle [ cx xValue, cy yValue, r "40", fill color ] []) :: result
    in
        Dict.foldl drawDisc [] dict


drawEmptyBoard : Board -> List (Svg msg)
drawEmptyBoard (Board row col) =
    let
        createHorizontal y =
            let
                yValue =
                    toString (y * 100)
            in
                line [ x1 "0", y1 yValue, x2 "700", y2 yValue, stroke "black", strokeWidth "5" ] []

        createVertical x =
            let
                xValue =
                    toString (x * 100)
            in
                line [ x1 xValue, y1 "0", x2 xValue, y2 "600", stroke "black", strokeWidth "5" ] []

        horizontal =
            List.map createHorizontal [0..row]

        vertical =
            List.map createVertical [0..col]
    in
        horizontal ++ vertical


drawColumnInserts : Game -> List (Svg Msg)
drawColumnInserts game =
    let
        color =
            case game.currentColor of
                Red ->
                    "red"

                Blue ->
                    "blue"

        xValue col =
            -50 + col * 100 |> toString

        drawInsert col =
            circle [ cx (xValue col), cy "650", r "30", fill color, stroke "black", strokeWidth "5", onClick (InsertDisc (col)) ] []
    in
        case game.board of
            Board row col ->
                List.filter (\c -> heightOfColumn game.gameState c < row) (Debug.log "a" [1..col])
                    |>{ List.map drawInsert
