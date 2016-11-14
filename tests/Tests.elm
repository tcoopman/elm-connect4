module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Connect4 exposing (update, Msg)


all : Test
all =
    describe "all"
        [ connect4
        ]


connect4 : Test
connect4 =
    describe "update"
        [ test "update" <|
            \() ->
                Expect.equal 1 (update Connect4.Increment 0)
        ]
