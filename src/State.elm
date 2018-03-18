module State exposing (init, update)

import Common.Api as Api
import Common.Language as Language exposing (Language)
import Dict exposing (Dict)
import Http
import Json.Decode
import Types exposing (Flags, Model, Msg(..))


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        language =
            flags.language
                |> Json.Decode.decodeValue Language.decode
                |> Result.withDefault Language.EN
    in
    ( { language = language
      , translations =
            { isLoading = True
            , dictionary = Dict.empty
            }
      , products = []
      }
    , Cmd.batch
        [ Http.send GetTranslations <| Api.getTranslations language
        , Http.send GetProducts Api.getProducts
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLanguage ->
            let
                newLanguage =
                    model.language |> Language.toggle
            in
            ( { model | language = newLanguage }
            , Http.send GetTranslations <| Api.getTranslations newLanguage
            )

        GetTranslations (Ok dictionary) ->
            ( { model
                | translations = { dictionary = dictionary, isLoading = False }
              }
            , Cmd.none
            )

        GetTranslations (Err _) ->
            ( { model
                | translations = { dictionary = model.translations.dictionary, isLoading = False }
              }
            , Cmd.none
            )

        GetProducts (Ok products) ->
            ( { model
                | products = products
              }
            , Cmd.none
            )

        GetProducts (Err string) ->
            let
                _ =
                    Debug.log "GetProducs error" string
            in
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
