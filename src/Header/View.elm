module Header.View exposing (..)

import Common.ButtonLink.View as ButtonLink
import Common.Logo
import Common.Types.Language as Language exposing (Language)
import Common.Types.Translations exposing (Translations)
import Common.Utilities exposing (onClickWithPreventDefault)
import Header.LanguageButton.View as LanguageButton
import Html exposing (Html, a, button, div, h3, header, img, span, text)
import Html.Attributes exposing (alt, attribute, class, classList, disabled, href, src)
import Types exposing (Msg(..), Route)


logo : Bool -> Html Msg
logo isCompact =
    div
        (ifThenElse isCompact [ onClickWithPreventDefault <| ChangeLocation "/" ] [])
        [ Common.Logo.image ]


languageButtons : Language -> Html Msg
languageButtons language =
    div [ class "language-buttons" ]
        [ LanguageButton.view Language.EN language ToggleLanguage
        , LanguageButton.view Language.ET language ToggleLanguage
        ]


externalLinks : Translations -> Html Msg
externalLinks translations =
    div [ class "external-links" ]
        [ ButtonLink.view
            [ ( "facebook", True ) ]
            translations.links_facebook
            [ img [ alt "links.facebook", src "/assets/images/facebook.svg" ] [] ]
        , ButtonLink.view
            [ ( "etsy", True ) ]
            translations.links_etsy
            [ img [ alt "links.etsy", src "/assets/images/etsy.svg" ] [] ]
        , ButtonLink.view
            [ ( "instagram", True ) ]
            translations.links_instagram
            [ img [ alt "link.instagram", src "/assets/images/instagram.svg" ] [] ]
        ]


contactInformation : Translations -> Html Msg
contactInformation translations =
    div [ class "contact-information" ]
        [ div [ class "avatar" ] [ img [ alt "avatar", src "/assets/images/avatar.jpg" ] [] ]
        , div []
            [ text translations.contact_name
            , div []
                [ text <| translations.phone ++ ": "
                , a [ class "link link--dark", href <| "tel:" ++ translations.phonenumber ]
                    [ text translations.phonenumber ]
                ]
            , div []
                [ text <| translations.email ++ ": "
                , a
                    [ class "link link--dark", href <| "mailto:" ++ translations.email_address ]
                    [ text translations.email_address ]
                ]
            ]
        ]


view : Translations -> Language -> Bool -> Html Msg
view translations language isCompact =
    header [ class "header container", classList [ ( "compact", isCompact ) ] ]
        ([ div
            [ class "logo-section", classList [ ( "compact", isCompact ) ] ]
            [ logo isCompact, languageButtons language ]
         ]
            ++ ifThenElse isCompact [] [ h3 [] [ text translations.header_slogan ] ]
            ++ ifThenElse isCompact [] [ contactInformation translations ]
            ++ ifThenElse isCompact [] [ externalLinks translations ]
        )


ifThenElse : Bool -> a -> a -> a
ifThenElse condition a1 a2 =
    if condition then
        a1
    else
        a2
