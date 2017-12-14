module Main exposing (..)

import Html exposing (program)
import Model exposing (Model)
import View exposing (view)
import Update exposing (Msg(..), update)
import Port exposing (newTweet)


init : ( Model, Cmd Msg )
init =
    ( [], Cmd.none )


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
