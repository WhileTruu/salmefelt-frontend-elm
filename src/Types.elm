module Types exposing (..)

import Common.Language exposing (Language)
import Common.Types.Product exposing (Product)
import Dict exposing (Dict)
import Http
import Json.Decode


type Msg
    = ToggleLanguage
    | GetProducts (Result Http.Error (List Product))
    | NoOp


type alias Flags =
    { language : Json.Decode.Value
    }


type alias Model =
    { language : Language
    , products : List Product
    }
