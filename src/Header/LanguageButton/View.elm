module Header.LanguageButton.View exposing (view)

import Common.Types.Language as Language exposing (Language)
import Html exposing (Html, button, img)
import Html.Attributes exposing (alt, class, disabled, src)
import Html.Events exposing (onClick)


view : Language -> Language -> msg -> Html msg
view buttonLanguage selectedLanguage msg =
    let
        languageString =
            buttonLanguage |> toString |> String.toLower
    in
    button
        [ class "language-button interactive"
        , onClick msg
        , disabled (buttonLanguage == selectedLanguage)
        ]
        [ img
            [ alt <| "languagebutton." ++ languageString
            , src <| "/assets/images/" ++ languageString ++ ".svg"
            ]
            []
        ]
