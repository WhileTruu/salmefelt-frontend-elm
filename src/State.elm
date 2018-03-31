module State exposing (init, update)

import Common.Api as Api
import Common.Language as Language exposing (Language)
import Http
import Json.Decode
import Types exposing (Flags, Model, Msg(..))


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { language =
            flags.language
                |> Json.Decode.decodeValue Language.decode
                |> Result.withDefault Language.EN
      , products = []
      }
    , Http.send GetProducts Api.getProducts
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLanguage ->
            ( { model | language = model.language |> Language.toggle }, Cmd.none )

        GetProducts (Ok products) ->
            ( { model | products = products }, Cmd.none )

        GetProducts (Err string) ->
            let
                _ =
                    Debug.log "GetProducs error" string
            in
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
