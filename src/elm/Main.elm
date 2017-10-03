module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


--import Html.Events exposing ( onClick )
-- MODEL


type alias Model =
    {
        lunchAt : String
    }


initialModel : Model
initialModel =
    {
    lunchAt = "foo"
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = \_ -> Sub.none
        }


type Msg
    = NoOp
    | Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div [ id "page-wrapper" ]
        [ div
            [ class "container"
            ]
            [ div [ class "sto-trzy" ]
                []
            , div [ class "sto-piec" ]
                []
            ]
        , div [ class "inner-container" ]
            [ text model.lunchAt
            ]
        ]
