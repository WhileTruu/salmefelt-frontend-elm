module Products.ProductButton.View exposing (root)

import Common.Types.Product exposing (Product)
import Common.Types.Product.Images exposing (ProductImage)
import Common.Utilities exposing (onClickWithPreventDefault)
import Html exposing (Html, a, button, div, h1, img, text)
import Html.Attributes exposing (alt, class, href, property, src)
import Routing
import Types exposing (Msg(..))


root : Int -> Product -> ProductImage -> Html Msg
root index product productImage =
    a
        [ class <| "product-button link link--dark"
        , href <| Routing.productPath index
        , onClickWithPreventDefault <| GoToProductPage (Routing.productPath product.id) index productImage
        ]
        [ div
            [ class "image-container" ]
            [ img [ class "image interactive", src productImage.thumbnail, alt "avatar" ] [] ]
        ]
