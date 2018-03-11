module Header.View exposing (..)

import Common.ButtonLink.View as ButtonLink
import Common.Language as Language exposing (Language)
import Common.Logo
import Common.Translations as Translations exposing (TranslateKey)
import Header.LanguageButton.View as LanguageButton
import Html exposing (Html, a, button, div, h3, img, span, text)
import Html.Attributes exposing (alt, attribute, class, disabled, href, src)
import Html.Events exposing (onClick)
import Types exposing (Msg(..))


logo : Html Msg
logo =
    div [] [ Common.Logo.image ]


languageButtons : Language -> Html Msg
languageButtons language =
    div [ class "language-buttons" ]
        [ LanguageButton.root Language.EN language ToggleLanguage
        , LanguageButton.root Language.ET language ToggleLanguage
        ]


externalLinks : TranslateKey -> Html Msg
externalLinks translateKey =
    div [ class "external-links" ]
        [ ButtonLink.root
            [ ( "facebook", True ) ]
            (translateKey "links.facebook")
            [ img [ alt "links.facebook", src "/assets/images/facebook.svg" ] [] ]
        , ButtonLink.root
            [ ( "etsy", True ) ]
            (translateKey "links.etsy")
            [ img [ alt "links.etsy", src "/assets/images/etsy.svg" ] [] ]
        ]


contactInformation : TranslateKey -> Html Msg
contactInformation translateKey =
    div [ class "contact-information" ]
        [ text <| translateKey "contact.name"
        , div []
            [ text <| translateKey "phone" ++ ": "
            , a [ class "link", href <| "tel:" ++ translateKey "phonenumber" ]
                [ text <| translateKey "phonenumber" ]
            ]
        , div []
            [ text <| translateKey "email" ++ ": "
            , a
                [ class "link", href <| "mailto:" ++ translateKey "email.address" ]
                [ text <| translateKey "email.address" ]
            ]
        ]


root : TranslateKey -> Language -> Html Msg
root translateKey language =
    div [ class "header" ]
        [ div [ class "container" ]
            [ div [ class "logo-section" ] [ logo, languageButtons language ]
            , h3 [] [ text <| translateKey "header.slogan" ]
            , contactInformation translateKey
            , externalLinks translateKey
            ]
        ]
