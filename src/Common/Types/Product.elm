module Common.Types.Product exposing (..)

import Json.Decode exposing (Decoder, bool, decodeString, decodeValue, field, int, list, string)


type alias ProductImage =
    { id : Int
    , fullPath : String
    , optimized : String
    , thumbnail : String
    }


type alias Product =
    { id : Int
    , position : Int
    , nameEN : String
    , nameET : String
    , descriptionEN : String
    , descriptionET : String
    , images : ProductImages
    , visible : Bool
    }


type ProductImages
    = ProductImages
        { head : ProductImage
        , tail : List ProductImage
        }


initProductImages : ProductImage -> List ProductImage -> ProductImages
initProductImages productImage productImageList =
    ProductImages { head = productImage, tail = productImageList }


selectProductImage : ProductImage -> ProductImages -> ProductImages
selectProductImage productImage (ProductImages { head, tail }) =
    initProductImages
        productImage
        (head :: tail |> List.filter (.id >> (/=) productImage.id))


productImageList : ProductImages -> List ProductImage
productImageList (ProductImages { head, tail }) =
    head :: tail


selectedProductImage : ProductImages -> ProductImage
selectedProductImage (ProductImages { head, tail }) =
    head


decoder : Decoder Product
decoder =
    Product
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "position" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "nameEn" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "nameEt" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "descriptionEn" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "descriptionEt" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "images" productImagesDecoder))
        |> Json.Decode.andThen (flip Json.Decode.map (field "visible" bool))


productImageDecoder : Decoder ProductImage
productImageDecoder =
    ProductImage
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "fullSize" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "optimized" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "thumbnail" string))


productImagesDecoder : Decoder ProductImages
productImagesDecoder =
    list productImageDecoder
        |> Json.Decode.andThen
            (\productImageList ->
                case productImageList of
                    a :: b ->
                        Json.Decode.succeed (initProductImages a b)

                    _ ->
                        Json.Decode.fail "there are no images"
            )
