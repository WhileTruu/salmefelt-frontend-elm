module Types exposing (..)

import Common.Language exposing (Language)
import Common.Translations exposing (Translations)
import Dict exposing (Dict)
import Http
import Json.Decode


type Msg
    = ToggleLanguage
    | GetTranslations (Result Http.Error (Dict String String))
    | NoOp


type alias Flags =
    { language : Json.Decode.Value
    }


type alias Model =
    { language : Language
    , translations : Translations
    }
