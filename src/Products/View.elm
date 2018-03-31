module Products.View exposing (root)

import Common.Types.Product exposing (Product)
import Common.Types.Translations exposing (Translations)
import Html exposing (Html, div)
import Html.Attributes exposing (class, property)
import Json.Encode
import Products.ProductButton.View as ProductButton
import Types exposing (Msg)


intro : Translations -> Html Msg
intro translations =
    div [ class "intro", property "innerHTML" (Json.Encode.string <| translations.body_text) ] []


root : Translations -> List Product -> Html Msg
root translations products =
    div
        [ class "container products" ]
        [ intro translations
        , div [ class "grid" ]
            (products
                |> List.foldl
                    (\product accumulator ->
                        if product.visible then
                            accumulator ++ List.map (.path >> (++) "/" >> ProductButton.root product.nameEN) product.images
                        else
                            accumulator
                    )
                    []
            )
        ]
