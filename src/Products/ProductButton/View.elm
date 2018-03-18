module Products.ProductButton.View exposing (root)

import Html exposing (Html, a, button, div, h1, img, text)
import Html.Attributes exposing (alt, class, href, property, src)
import Types exposing (Msg)


root : String -> String -> Html Msg
root name url =
    a [ class <| "product-button link link--dark", href url ]
        [ div
            [ class "image-container" ]
            [ img [ class "image interactive", src url, alt "avatar" ] [] ]
        , div [ class "product-name" ] [ text name ]
        ]
