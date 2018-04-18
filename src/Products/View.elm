module Products.View exposing (root)

import Common.Types.Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
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


root : Translations -> Language -> Dict Int Product -> Html Msg
root translations language products =
    div
        [ class "container products" ]
        [ intro translations
        , div [ class "grid" ]
            (products
                |> Dict.toList
                |> List.sortBy (Tuple.second >> .position)
                |> List.foldl
                    (\( index, product ) accumulator ->
                        if product.visible then
                            accumulator
                                ++ (ProductImages.list product.images
                                        |> List.map (ProductButton.root language index product)
                                   )
                        else
                            accumulator
                    )
                    []
            )
        ]
