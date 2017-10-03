module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time)

type alias Model =
    {
        lunchAt : Time
        , lowerRoomOk: Maybe Bool
        , higherRoomOk: Maybe Bool
    }


initialModel : Model
initialModel =
    {
       lunchAt = 9872345987
       , lowerRoomOk = Nothing
       , higherRoomOk = Nothing
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
            [ div [ class ( if model.lowerRoomOk == Just False then
                    "sto-trzy bad"
                else if model.lowerRoomOk == Just True then
                    "sto-trzy good"
                else
                    "sto-trzy"
                ) ]
                []
            , div [ class "sto-piec" ]
                []
            ]
        , div [ class "inner-container" ]
            [
                div [ class "inner-top"]
                    [
                        div [ class "clock-container"]
                            [
                                div []
                                    [
                                        text (toString model.lunchAt)
                                    ]
                                , div [ class "inc-dec"]
                                    [
                                         span [class "bad"]
                                            [
                                                text "-"
                                            ]
                                         , span [class "good"]
                                            [
                                                text "+"
                                            ]
                                    ]
                            ]
                    ]

                , div [ class "inner-bottom"] [
                    div []
                        [
                            div [] [
                                span [] [text "103"]
                            ]
                            , div [] [
                                div [class "good"] [
                                    span [] [text "Jestesmy glodni"]
                                ]
                                ,div [class "bad"] [
                                    span [] [text "Nie czekajcie"]
                                ]
                            ]
                        ]
                    , div []
                        [
                            div [] [
                                span [] [text "103"]
                            ]
                            , div [] [
                                div [class "good"] [
                                    span [] [text "Jestesmy glodni"]
                                ]
                                ,div [class "bad"] [
                                    span [] [text "Nie czekajcie"]
                                ]
                            ]
                        ]
            ]
        ]
    ]
