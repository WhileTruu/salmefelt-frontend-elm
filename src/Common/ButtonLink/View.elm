module Common.ButtonLink.View exposing (..)

import Html exposing (Html, a, button, div, h3, img, span, text)
import Html.Attributes exposing (alt, attribute, class, classList, disabled, href, src)


root : List ( String, Bool ) -> String -> List (Html msg) -> Html msg
root classNames url children =
    a
        [ class "button-link", classList classNames, href url ]
        children
