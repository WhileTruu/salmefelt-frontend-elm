module Types exposing (..)

import Common.Language exposing (Language)
import Common.Translations exposing (Translations)
import Common.Types.Product exposing (Product)
import Dict exposing (Dict)
import Http
import Json.Decode


type Msg
    = ToggleLanguage
    | GetTranslations (Result Http.Error (Dict String String))
    | GetProducts (Result Http.Error (List Product))
    | NoOp


type alias Flags =
    { language : Json.Decode.Value
    }


type alias Model =
    { language : Language
    , translations : Translations
    , products : List Product
    }
