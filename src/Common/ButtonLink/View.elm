module Common.ButtonLink.View exposing (..)

import Html exposing (Html, a, button, div, h3, img, span, text)
import Html.Attributes exposing (alt, attribute, class, classList, disabled, href, src)


view : List ( String, Bool ) -> String -> List (Html msg) -> Html msg
view classNames url children =
    a
        [ class "button interactive", classList classNames, href url ]
        children
