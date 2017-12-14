port module Main exposing (..)

import Html exposing (..)
import List


port newTweet : (String -> msg) -> Sub msg


type alias Tweet =
    String


type alias Model =
    List Tweet


init : ( Model, Cmd Msg )
init =
    ( [], Cmd.none )


type Msg
    = NewTweet String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTweet tweet ->
            ( List.append [ tweet ] model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        (List.map (\tweet -> text tweet) model)


subscriptions : Model -> Sub Msg
subscriptions model =
    newTweet NewTweet


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
