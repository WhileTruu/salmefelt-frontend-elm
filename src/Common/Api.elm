module Common.Api exposing (..)

import Common.Language exposing (Language)
import Common.Translations as Translations exposing (Translations)
import Http
import Json.Decode


getTranslations : Language -> Http.Request Translations
getTranslations language =
    let
        url =
            "/assets/" ++ (language |> toString |> String.toLower) ++ ".json"
    in
    Http.get url (Json.Decode.dict Json.Decode.string)
