module Common.Api exposing (..)

import Common.Types.Product as Types
import Http
import Json.Decode
import Json.Encode
import Task exposing (Task)


getProducts : Http.Request (List Types.Product)
getProducts =
    Http.get "/api/v1/products/" (Json.Decode.list Types.decoder)


getProductsWithGraphQl : Task Http.Error (List Types.Product)
getProductsWithGraphQl =
    Http.post
        "/graphql"
        (Http.jsonBody graphQlJsonQuery)
        (Json.Decode.list Types.decoder)
        |> Http.toTask


graphQlJsonQuery : Json.Decode.Value
graphQlJsonQuery =
    Json.Encode.object
        [ ( "query"
          , Json.Encode.string
                """
                  {
                    products {
                      id,
                      nameEt
                      nameEn
                      images: productImages {
                        id,
                        path: image
                      }
                    }
                  }
                """
          )
        , ( "variables", Json.Encode.null )
        , ( "operationName", Json.Encode.null )
        ]
