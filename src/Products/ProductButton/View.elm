module Products.ProductButton.View exposing (root)

import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images exposing (ProductImage)
import Common.Utilities exposing (onClickWithPreventDefault)
import Html exposing (Html, a, button, div, h1, img, text)
import Html.Attributes exposing (alt, class, href, property, src)
import Routing
import Types exposing (Msg(..))


root : Language -> Int -> Product -> ProductImage -> Html Msg
root language index product productImage =
    a
        [ class <| "product-button link link--dark"
        , href <| Routing.productPath index
        , onClickWithPreventDefault <| GoToProductPage (Routing.productPath product.id) index productImage
        ]
        [ div
            [ class "image-container" ]
            [ img [ class "image interactive", src productImage.thumbnail, alt "avatar" ] [] ]
        , div [ class "product-name" ] [ text <| getName language product ]
        ]


getName : Language -> Product -> String
getName language product =
    case language of
        Language.EN ->
            product.nameEN

        Language.ET ->
            product.nameET
