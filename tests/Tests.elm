module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Connect4 exposing (add)


all : Test
all =
    describe "A Test Suite"
        [ test "Addition"
            <| \() ->
                Expect.equal (3 + 7) 10
        , test "String.left"
            <| \() ->
                Expect.equal "a" (String.left 1 "abcdefg")
        , test "Test add"
            <| \() -> Expect.equal 3 (add 1 2)
        ]