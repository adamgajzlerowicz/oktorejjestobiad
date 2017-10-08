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
    = ChangeTeamState StanGlodu Team
    | IncrementTime
    | DecrementTime

decide : Maybe Bool -> StanGlodu -> Maybe Bool
decide current state
    =
        if state == Glodni && (current == Nothing || current == Just False)  then
         Just True
        else if state == NieCzekajcie && (current == Nothing || current == Just True) then
         Just False
        else if state == Glodni && current == Just True then
         Nothing
        else if state == NieCzekajcie && current == Just False then
         Nothing
        else
          current


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =

    case msg of

        ChangeTeamState state team ->
            let
                decisionLower = decide model.lowerRoomOk  state
                decisionHigher = decide model.higherRoomOk state
            in
            (
                case team of
                    StoTrzy -> { model | lowerRoomOk = decisionLower }
                    StoPiec -> { model | higherRoomOk = decisionHigher}
            , Cmd.none)
        IncrementTime ->
            (model , Cmd.none)
        DecrementTime ->
            (model , Cmd.none)

component: String -> Team -> Html Msg
component content room =
    div []
        [
            div [] [
                span [class "darkgray"] [text content]
            ]
            , div [] [
                div [class "bad"] [
                    span [onClick (ChangeTeamState NieCzekajcie room)] [text "Nie czekajcie"]
                ]
                ,div [class "good"] [
                     span [onClick (ChangeTeamState Glodni room)] [text "Jestesmy glodni"]
                 ]
            ]
        ]


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
            , div [ class ( if model.higherRoomOk == Just False then
                  "sto-piec bad"
              else if model.higherRoomOk == Just True then
                  "sto-piec good"
              else
                  "sto-piec"
              ) ]
              []
            ]
        , div [ class "inner-container" ]
            [
                div [ class "inner-top"]
                    [
                        div [ class "clock-container"]
                            [
                                div [ class "darkgray" ]
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
                    component "103" StoTrzy
                    , component "105" StoPiec
            ]
        ]
    ]
