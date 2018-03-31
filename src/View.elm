module View exposing (root)

import Common.Translations as Translations
import Common.Types.Translations exposing (Translations)
import Header.View
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (class)
import Products.View
import Types exposing (..)


root : Model -> Html Msg
root model =
    let
        translations : Translations
        translations =
            Translations.getTranslationsForLanguage model.language
    in
    div [ class "app" ]
        [ Header.View.root translations model.language
        , Products.View.root translations model.products
        ]
