module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time)
import Html.Events exposing ( onClick )

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

type Team
    = StoTrzy
    | StoPiec

type StanGlodu
    = Glodni
    | NieCzekajcie

type Msg
    = ChangeTeamState Team StanGlodu
    | IncrementTime
    | DecrementTime



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeTeamState team state ->
            (
                case team of
                    StoTrzy -> if state == Glodni && (model.lowerRoomOk == Nothing || model.lowerRoomOk == Just False)  then
                            { model | lowerRoomOk = Just True}
                        else if state == NieCzekajcie && (model.lowerRoomOk == Nothing || model.lowerRoomOk == Just True) then
                            { model | lowerRoomOk = Just False}
                        else if state == Glodni && model.lowerRoomOk == Just True then
                            { model | lowerRoomOk = Nothing}
                        else if state == NieCzekajcie && model.lowerRoomOk == Just False then
                            { model | lowerRoomOk = Nothing}
                        else
                            model
                    StoPiec -> { model | lowerRoomOk = Just False}

            , Cmd.none)
        IncrementTime ->
            (model , Cmd.none)
        DecrementTime ->
            (model , Cmd.none)
--            ({ model | lowerRoomOk = Just False }, Cmd.none)

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
                                         span [class "bad", onClick DecrementTime]
                                            [
                                                text "-"
                                            ]
                                         , span [class "good", onClick IncrementTime]
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
                                    span [onClick (ChangeTeamState StoTrzy Glodni)] [text "Jestesmy glodni"]
                                ]
                                ,div [class "bad"] [
                                    span [onClick (ChangeTeamState StoTrzy NieCzekajcie)] [text "Nie czekajcie"]
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
                                    span [onClick (ChangeTeamState StoPiec Glodni)] [text "Jestesmy glodni"]
                                ]
                                ,div [class "bad"] [
                                    span [onClick (ChangeTeamState StoPiec NieCzekajcie)] [text "Nie czekajcie"]
                                ]
                            ]
                        ]
            ]
        ]
    ]
