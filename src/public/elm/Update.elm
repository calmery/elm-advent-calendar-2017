module Update exposing (Msg(..), update)

import Model exposing (Model)
import Port exposing (notification)
import Util exposing (decodeTweet)
import List


type Msg
    = NewTweet String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTweet string ->
            let
                decoded =
                    decodeTweet string
            in
                case decoded of
                    Ok tweet ->
                        ( List.append [ tweet ] <| List.take 100 model, notification tweet.text )

                    Err _ ->
                        ( model, Cmd.none )
