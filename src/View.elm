module View exposing (root)

import Common.Translations as Translations exposing (TranslateKey)
import Header.View
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (class)
import Products.View
import Types exposing (..)


root : Model -> Html Msg
root model =
    let
        translateKey : TranslateKey
        translateKey =
            Translations.translate model.translations
    in
    div [ class "app" ]
        [ Header.View.root translateKey model.language
        , Products.View.root translateKey model.products
        ]
