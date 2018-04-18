module Products.Product.View exposing (root)

import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Html exposing (Html, button, div, h2, img, span, text)
import Html.Attributes exposing (alt, class, src)
import Html.Events exposing (onClick)
import Types exposing (Msg(..))


type alias Properties =
    { language : Language
    , index : Int
    , product : Product
    }


smallThumbnail : Int -> Bool -> ProductImage -> Html Msg
smallThumbnail index selected productImage =
    button [ class "button interactive", onClick <| SelectProductImage index productImage ]
        [ img [ class "", src <| "/" ++ productImage.thumbnail, alt "avatar" ] [] ]


imageView : Properties -> Html Msg
imageView { index, product } =
    div [ class "section" ]
        [ div [ class "buttons" ]
            (ProductImages.list product.images
                |> List.map
                    (\image ->
                        if image == ProductImages.selected product.images then
                            smallThumbnail index True image
                        else
                            smallThumbnail index False image
                    )
            )
        , img
            [ src <| "/" ++ (product.images |> (ProductImages.selected >> .optimized))
            , alt product.nameEN
            ]
            []
        ]


description : { name : String, description : String } -> Html Msg
description { name, description } =
    div [ class "section" ]
        [ h2 [] [ text name ]
        , text description
        ]


root : Properties -> Html Msg
root properties =
    div [ class "container" ]
        [ div [ class "product-view" ]
            [ imageView properties
            , description (getNameAndDescription properties)
            ]
        ]


getNameAndDescription : Properties -> { name : String, description : String }
getNameAndDescription { language, product } =
    case language of
        Language.EN ->
            { name = product.nameEN, description = product.descriptionEN }

        Language.ET ->
            { name = product.nameET, description = product.descriptionET }
