module View exposing (root)

import Common.Translations as Translations
import Common.Types.Translations exposing (Translations)
import Dict
import Header.View
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (class)
import Products.Product.View as ProductView
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
        [ Header.View.root translations model.language model.route
        , page translations model
        ]


page : Translations -> Model -> Html Msg
page translations model =
    case model.route of
        Types.Root ->
            Products.View.root translations model.language model.products

        Types.Product id ->
            model.products
                |> Dict.get id
                |> Maybe.map (\product -> ProductView.root { index = id, product = product, language = model.language })
                |> Maybe.withDefault (text "")
