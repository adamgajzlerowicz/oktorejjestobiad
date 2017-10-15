port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time, second, now)
import Html.Events exposing (onClick)
import Time.Format exposing (format)
--import Task exposing (..)

type alias TransportedModel =
    {
        lunchAt : Time
        , lowerRoomOk: Maybe Bool
        , higherRoomOk: Maybe Bool
    }


type alias Model =
    {
        state: TransportedModel
        , currentTime: Time
        , loading: Bool
    }


initialModel : Model
initialModel =
    {
        state = {
            lunchAt = 0
            , lowerRoomOk = Nothing
            , higherRoomOk = Nothing
        }
       , currentTime = 0
       , loading = True
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

port apiData: (TransportedModel -> msg ) -> Sub msg

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.batch
    [
        Time.every second SetTime
        , apiData SetState
    ]


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
    | SetState TransportedModel

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
                decisionLower = decide model.state.lowerRoomOk  state
                decisionHigher = decide model.state.higherRoomOk state
                slice = model.state
                stoTrzyState = {slice | lowerRoomOk = decisionLower}
                stoPiecState = {slice | higherRoomOk = decisionHigher}
            in
            (
                case team of
                    StoTrzy -> { model | state = stoTrzyState }
                    StoPiec -> { model | state = stoPiecState}
            , Cmd.none)

        IncrementTime ->
            let
                state = model.state
                lunchCommencingAt = model.state.lunchAt + 60000
                updated = {state | lunchAt = lunchCommencingAt}
            in
                ({model | state = updated}, Cmd.none)

        DecrementTime ->
            let
                state = model.state
                lunchCommencingAt = model.state.lunchAt - 60000
                updated = {state | lunchAt = lunchCommencingAt}
            in
                ({model | state = updated}, Cmd.none)
        SetTime newTime ->
            ({model | currentTime = newTime}, Cmd.none)

        SetState newState ->
            ({model | state = newState, loading = False}, Cmd.none)

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
                , div [class "good"] [
                     span [onClick (ChangeTeamState Glodni room)] [text "Jestesmy glodni"]
                 ]
            ]
        ]


view : Model -> Html Msg
view model =
    let
        containerClass =
            if (model.state.lowerRoomOk == Just True && model.state.higherRoomOk == Just True)
            then "container positive"
            else if  (model.state.lowerRoomOk == Just False && model.state.higherRoomOk == Just False)
            then "container negative"
            else "container"
    in
    if model.loading == False then
        div [ id "page-wrapper" ]
            [ div
                [ class containerClass
                ]
                [ div [ class ( if model.state.lowerRoomOk == Just False then
                        "sto-trzy bad"
                    else if model.state.lowerRoomOk == Just True then
                        "sto-trzy good"
                    else
                        "sto-trzy"
                    ) ]
                    []
                , div [ class ( if model.state.higherRoomOk == Just False then
                      "sto-piec bad"
                  else if model.state.higherRoomOk == Just True then
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
                                            div [class "timeBig"] [text (format "%H:%M:%S" model.state.lunchAt)]
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
    else
        div [] [text "loading"]
