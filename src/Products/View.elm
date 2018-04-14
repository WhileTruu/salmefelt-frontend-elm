module Products.View exposing (root)

import Common.Types.Product exposing (Product, productImageList)
import Common.Types.Translations exposing (Translations)
import Dict exposing (Dict)
import Html exposing (Html, div)
import Html.Attributes exposing (class, property)
import Json.Encode
import Products.ProductButton.View as ProductButton
import Types exposing (Msg)


intro : Translations -> Html Msg
intro translations =
    div [ class "intro", property "innerHTML" (Json.Encode.string <| translations.body_text) ] []


root : Translations -> Dict Int Product -> Html Msg
root translations products =
    div
        [ class "container products" ]
        [ intro translations
        , div [ class "grid" ]
            (products
                |> Dict.toList
                |> List.foldl
                    (\( index, product ) accumulator ->
                        if product.visible then
                            accumulator
                                ++ (productImageList product.images
                                        |> List.map (ProductButton.root index product)
                                   )
                        else
                            accumulator
                    )
                    []
            )
        ]
