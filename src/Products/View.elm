module Products.View exposing (root)

import Common.Translations as Translations exposing (TranslateKey)
import Common.Types.Product exposing (Product)
import Html exposing (Html, div)
import Html.Attributes exposing (class, property)
import Json.Encode
import Products.ProductButton.View as ProductButton
import Types exposing (Msg)


intro : TranslateKey -> Html Msg
intro translateKey =
    div [ class "intro", property "innerHTML" (Json.Encode.string <| translateKey "body.text") ] []


root : TranslateKey -> List Product -> Html Msg
root translateKey products =
    div
        [ class "container products" ]
        [ intro translateKey
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
