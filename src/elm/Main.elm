port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time, second, now)
import Html.Events exposing (onClick)
import Time.Format exposing (format)
import Task exposing (..)
import Time.DateTime as DateTime exposing (fromTimestamp, toTimestamp)

type alias Model =
    {
        lunchAt : Time
        , lowerRoomOk: Maybe Bool
        , higherRoomOk: Maybe Bool
        , currentTime: Time
    }


initialModel : Model
initialModel =
    {
       lunchAt = 0
       , lowerRoomOk = Nothing
       , higherRoomOk = Nothing
       , currentTime = 0
    }

init : ( Model, Cmd Msg )
init =
    (initialModel, Cmd.none)

main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }

subscriptions: Model -> Sub Msg
subscriptions model =
    Time.every second SetTime

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
    | SetTime Time

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
            ({model | lunchAt = model.lunchAt + 60000}, Cmd.none)
        DecrementTime ->
            ({model | lunchAt = model.lunchAt - 60000}, Cmd.none)
        SetTime newTime->
            ({model | currentTime = newTime}, Cmd.none)

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
    let
        containerClass =
            if (model.lowerRoomOk == Just True && model.higherRoomOk == Just True)
            then "container positive"
            else if  (model.lowerRoomOk == Just False && model.higherRoomOk == Just False)
            then "container negative"
            else "container"
    in
    div [ id "page-wrapper" ]
        [ div
            [ class containerClass
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
                                        div [class "timeBig"] [text (format "%H:%M:%S" model.lunchAt)]
                                        , div [class "timeSmall"] [text (format "%H:%M:%S" model.currentTime)]
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
