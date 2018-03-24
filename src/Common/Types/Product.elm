module Common.Types.Product exposing (..)

import Json.Decode exposing (Decoder, bool, decodeString, decodeValue, field, int, list, string)


type alias ProductImage =
    { id : Int
    , path : String
    }


type alias Product =
    { id : Int
    , nameEN : String
    , nameET : String
    , descriptionEN : String
    , descriptionET : String
    , images : List ProductImage
    , visible : Bool
    }


decoder : Decoder Product
decoder =
    Product
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "nameEn" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "nameEt" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "descriptionEn" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "descriptionEt" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "images" (list productImageDecoder)))
        |> Json.Decode.andThen (flip Json.Decode.map (field "visible" bool))


productImageDecoder : Decoder ProductImage
productImageDecoder =
    ProductImage
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "path" string))
