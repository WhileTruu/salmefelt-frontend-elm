module Common.Api exposing (..)

import Common.Language exposing (Language)
import Common.Types.Product as Types
import Dict exposing (Dict)
import Http
import Json.Decode


getTranslations : Language -> Http.Request (Dict String String)
getTranslations language =
    let
        url =
            "/assets/" ++ (language |> toString |> String.toLower) ++ ".json"
    in
    Http.get url (Json.Decode.dict Json.Decode.string)


getProducts : Http.Request (List Types.Product)
getProducts =
    Http.get "/api/v1/products/" (Json.Decode.list Types.decoder)
