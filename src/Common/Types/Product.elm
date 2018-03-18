module Common.Types.Product exposing (..)

import Json.Decode exposing (Decoder, decodeString, decodeValue, field, int, list, string)


type alias ProductImage =
    { id : Int
    , productId : Int
    , url : String
    , dateCreated : String
    , dateModified : String
    }


type alias Product =
    { id : Int
    , nameEN : String
    , nameET : String
    , descriptionEN : String
    , descriptionET : String
    , images : List ProductImage
    }


decoder : Decoder Product
decoder =
    Product
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "name_en" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "name_et" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "description_en" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "description_et" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "productimages" (list productImageDecoder)))


productImageDecoder : Decoder ProductImage
productImageDecoder =
    ProductImage
        |> Json.Decode.succeed
        |> Json.Decode.andThen (flip Json.Decode.map (field "id" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "productId" int))
        |> Json.Decode.andThen (flip Json.Decode.map (field "image" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "date_created" string))
        |> Json.Decode.andThen (flip Json.Decode.map (field "date_modified" string))
