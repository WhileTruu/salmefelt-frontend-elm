module Header.LanguageButton.View exposing (root)

import Common.Language as Language exposing (Language)
import Html exposing (Html, button, img)
import Html.Attributes exposing (alt, class, disabled, src)
import Html.Events exposing (onClick)


root : Language -> Language -> msg -> Html msg
root buttonLanguage selectedLanguage msg =
    let
        languageString =
            buttonLanguage |> toString |> String.toLower
    in
    button
        [ class "language-button"
        , onClick msg
        , disabled (buttonLanguage == selectedLanguage)
        ]
        [ img
            [ alt <| "languagebutton." ++ languageString
            , src <| "/assets/images/" ++ languageString ++ ".svg"
            ]
            []
        ]
