module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
--import Html.Events exposing ( onClick )

-- MODEL
type alias Model =
    {
        lunchAt: String
    }

initialModel : Model
initialModel =
    {
        lunchAt = "foo"
    }


whatevahCmd : String -> Cmd Msg
whatevahCmd query =
    "dupa"

-- APP
main : Program Never Model Msg
main =
 Html.program
         { view = view
         , update = update
         , init = (initialModel, whatevahCmd)
         , subscriptions = \_ -> Sub.none
         }




-- UPDATE
type Msg = NoOp | Increment

update : Msg -> Model -> Model
update msg model =
    model
--  case msg of
--    NoOp -> model
--    Increment -> model + 1


view : Model -> Html Msg
view model =
    div [id "page-wrapper"] [
        div [
            class "container"
        ][
            div [class "sto-trzy"]
            []
            , div [class "sto-piec"]
            []
        ]
        , div [class "inner-container"]
            [
             text "dupa"
            ]
    ]
