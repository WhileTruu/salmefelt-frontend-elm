module Common.Api exposing (..)

import Common.Language exposing (Language)
import Common.Types.Product as Types
import Dict exposing (Dict)
import Http
import Json.Decode


getProducts : Http.Request (List Types.Product)
getProducts =
    Http.get "/api/v1/products/" (Json.Decode.list Types.decoder)
