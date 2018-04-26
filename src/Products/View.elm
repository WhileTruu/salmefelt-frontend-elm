module Products.View exposing (root)

import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Common.Types.Translations exposing (Translations)
import Dict exposing (Dict)
import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (class, property)
import Json.Encode
import Products.ProductButton.View as ProductButton
import Types exposing (Msg)


intro : Translations -> Html Msg
intro translations =
    div [ class "intro", property "innerHTML" (Json.Encode.string <| translations.body_text) ] []


getName : Language -> Product -> String
getName language product =
    case language of
        Language.EN ->
            product.nameEN

        Language.ET ->
            product.nameET


productList : Language -> Int -> Product -> Html Msg
productList language index product =
    div [ class "product" ]
        [ h2 []
            [ text <| getName language product ]
        , div [ class "grid" ]
            (ProductImages.list product.images
                |> List.map (ProductButton.root index product)
            )
        ]


root : Translations -> Language -> Dict Int Product -> Html Msg
root translations language products =
    div
        [ class "container products" ]
        [ intro translations
        , div []
            (products
                |> Dict.toList
                |> List.sortBy (Tuple.second >> .position)
                |> List.foldl
                    (\( index, product ) accumulator ->
                        if product.visible then
                            accumulator ++ [ productList language index product ]
                        else
                            accumulator
                    )
                    []
            )
        ]
