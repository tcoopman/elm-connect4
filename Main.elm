module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.App as App
import Svg exposing (Svg, circle, svg, line)
import Svg.Attributes exposing (width, height, viewBox, cx, cy, r, fill, x1, x2, y1, y2, stroke, strokeWidth)
import Svg.Events exposing (onClick)


main =
    App.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    Int


model : Model
model =
    0


type Msg
    = Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1


view : Model -> Html Msg
view model =
    div []
        [ svg [ width "700", height "700", viewBox "0 0 700 700" ]
            ([ circle [ cx "50", cy "550", r "40", fill "red" ] []
             , circle [ cx "250", cy "550", r "40", fill "red" ] []
             , circle [ cx "250", cy "450", r "40", fill "blue" ] []
             ]
                ++ drawEmptyBoard
                ++ [ circle [ cx "50", cy "650", r "30", fill "red", stroke "black", strokeWidth "5", onClick Increment ] [] ]
            )
        , div [] [ text (toString model) ]
        ]


drawEmptyBoard : List (Svg msg)
drawEmptyBoard =
    [ line [ x1 "0", y1 "0", x2 "0", y2 "600", stroke "black", strokeWidth "5" ] []
    , line [ x1 "100", y1 "0", x2 "100", y2 "600", stroke "black", strokeWidth "5" ] []
    , line [ x1 "200", y1 "0", x2 "200", y2 "600", stroke "black", strokeWidth "5" ] []
    , line [ x1 "700", y1 "0", x2 "700", y2 "600", stroke "black", strokeWidth "5" ] []
    , line [ x1 "0", y1 "0", x2 "700", y2 "0", stroke "black", strokeWidth "5" ] []
    , line [ x1 "0", y1 "600", x2 "700", y2 "600", stroke "black", strokeWidth "5" ] []
    ]
