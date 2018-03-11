module Main exposing (..)

import Html
import State
import Types exposing (Flags, Model, Msg)
import View


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = View.root
        , init = State.init
        , update = State.update
        , subscriptions = always Sub.none
        }
