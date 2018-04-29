module Pages.Main.View exposing (view)

import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Common.Types.Translations exposing (Translations)
import Dict exposing (Dict)
import Header.View
import Html exposing (Html, div, h2, p, section, text)
import Html.Attributes exposing (class, property)
import Json.Encode
import Pages.Main.ProductButton.View as ProductButton
import Types exposing (Msg)


intro : Translations -> Html Msg
intro translations =
    p [ class "intro", property "innerHTML" (Json.Encode.string <| translations.body_text) ] []


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
        [ h2 [] [ text <| getName language product ]
        , div [ class "grid" ]
            (ProductImages.list product.images
                |> List.map (ProductButton.view index product)
            )
        ]


view : Translations -> Language -> Dict Int Product -> List (Html Msg)
view translations language products =
    [ Header.View.view translations language False
    , section
        [ class "container products" ]
        ([ intro translations ]
            ++ (products
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
        )
    ]
