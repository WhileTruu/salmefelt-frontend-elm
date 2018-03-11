module Test.State exposing (..)

import Common.Api as Api
import Common.Language as Language exposing (Language)
import Common.Translations exposing (Translations)
import Dict exposing (Dict)
import Expect
import Http
import Json.Encode
import State
import Test exposing (..)
import Types


fakeTranslations : Translations
fakeTranslations =
    Dict.fromList [ ( "bleep", "bloop" ), ( "meep", "moop" ) ]


init : Test
init =
    describe "init"
        [ describe "when initializing without language from localstorage" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.init { language = Json.Encode.null }
            in
            [ test "language defaults to english" <|
                \_ ->
                    result |> Tuple.first |> .language |> Expect.equal Language.EN
            ]
        , describe "when initializing with language from localstorage" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.init { language = Json.Encode.string "ET" }
            in
            [ test "language is decoded" <|
                \_ ->
                    result |> Tuple.first |> .language |> Expect.equal Language.ET
            ]
        ]


update : Test
update =
    describe "update"
        [ describe "when switching between languages" <|
            let
                result : ( Types.Model, Cmd Types.Msg )
                result =
                    State.update Types.ToggleLanguage (Tuple.first <| State.init { language = Json.Encode.string "EN" })
            in
            [ test "langugage is changed" <|
                \_ ->
                    result |> Tuple.first |> .language |> Expect.equal Language.ET
            , test "the update results in another command (hopefully requesting new translations)" <|
                \_ ->
                    result
                        |> Tuple.second
                        |> Expect.notEqual Cmd.none
            ]
        , describe "when getting translations is a success"
            [ test "translations are added to the state" <|
                \_ ->
                    State.update
                        (Types.GetTranslations (Result.Ok fakeTranslations))
                        (Tuple.first <| State.init { language = Json.Encode.string "EN" })
                        |> Tuple.first
                        |> .translations
                        |> Expect.equal fakeTranslations
            ]
        , describe "when getting translations is a failure"
            [ test "nothing changes" <|
                \_ ->
                    State.update
                        (Types.GetTranslations (Result.Err Http.NetworkError))
                        (Tuple.first <| State.init { language = Json.Encode.string "EN" })
                        |> Tuple.first
                        |> .translations
                        |> Expect.equal Dict.empty
            ]
        , describe "when called with NoOp"
            [ test "returns current state, changing nothing" <|
                let
                    initialModel : Types.Model
                    initialModel =
                        Tuple.first <| State.init { language = Json.Encode.string "EN" }
                in
                \_ ->
                    State.update Types.NoOp initialModel |> Expect.equal ( initialModel, Cmd.none )
            ]
        ]
