module Common.Utilities exposing (onClickWithPreventDefault)

import Html
import Html.Events
import Json.Decode


onClickWithPreventDefault : msg -> Html.Attribute msg
onClickWithPreventDefault message =
    let
        options : Html.Events.Options
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
    Html.Events.onWithOptions "click" options (Json.Decode.succeed message)
