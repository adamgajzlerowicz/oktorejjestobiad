module Main exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
--import Html.Events exposing ( onClick )

-- component import example
--import Components.Hello exposing ( hello )


-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model =
    {
        lunchAt: String
    }

model : number
model = 0


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
