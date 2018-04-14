module Products.Product.View exposing (root)

import Common.Types.Product exposing (Product, ProductImage, productImageList, selectedProductImage)
import Common.Utilities exposing (onClickWithPreventDefault)
import Html exposing (Html, button, div, h2, img, span, text)
import Html.Attributes exposing (alt, class, src)
import Types exposing (Msg(..))


type alias Properties =
    { index : Int
    , product : Product
    }


smallThumbnail : Int -> ProductImage -> Html Msg
smallThumbnail index productImage =
    button [ class "button interactive", onClickWithPreventDefault <| SelectProductImage index productImage ]
        [ img [ class "", src <| "/" ++ productImage.thumbnail, alt "avatar" ] [] ]


imageView : Properties -> Html Msg
imageView { index, product } =
    div [ class "section" ]
        [ div [ class "buttons" ]
            (productImageList product.images
                |> List.filterMap
                    (\image ->
                        if image == selectedProductImage product.images then
                            Nothing
                        else
                            Just (smallThumbnail index image)
                    )
            )
        , img
            [ src <| "/" ++ (product.images |> (selectedProductImage >> .optimized))
            , alt product.nameEN
            ]
            []
        ]


description : Properties -> Html Msg
description { product } =
    div [ class "section" ]
        [ h2 [] [ text product.nameEN ]
        , text product.descriptionEN
        ]


root : Properties -> Html Msg
root properties =
    div [ class "container" ]
        [ div [ class "product-view" ]
            [ imageView properties
            , description properties
            ]
        ]
