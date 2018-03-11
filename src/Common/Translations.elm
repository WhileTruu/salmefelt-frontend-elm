module Common.Translations exposing (TranslateKey, Translations, noTranslation, translate)

import Dict exposing (Dict)


noTranslation : String
noTranslation =
    "😢💩 Translate me."


type alias Translations =
    Dict String String


type alias TranslateKey =
    String -> String


translate : Translations -> String -> String
translate translations =
    flip Dict.get translations >> Maybe.withDefault noTranslation
