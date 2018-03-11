module Common.Translations exposing (TranslateKey, Translations, noTranslation, translate)

import Dict exposing (Dict)


noTranslation : String
noTranslation =
    "😢💩 Translate me."


loading : String
loading =
    "Loading..."


type alias Translations =
    { dictionary : Dict String String
    , isLoading : Bool
    }


type alias TranslateKey =
    String -> String


translate : Translations -> String -> String
translate translations =
    flip Dict.get translations.dictionary
        >> Maybe.withDefault
            (if translations.isLoading then
                loading
             else
                noTranslation
            )
