port module Main exposing (..)

import Html exposing (..)
import List
import Json.Decode exposing (..)


port newTweet : (String -> msg) -> Sub msg


type alias Tweet =
    { user : User
    , text : String
    , created_at : String
    }


type alias User =
    { profile_image_url : String
    , name : String
    , screen_name : String
    }


decodeTweet : String -> Result String Tweet
decodeTweet response =
    decodeString tweetDecoder response


tweetDecoder : Decoder Tweet
tweetDecoder =
    map3 Tweet
        (field "user" userDecoder)
        (field "text" string)
        (field "created_at" string)


userDecoder : Decoder User
userDecoder =
    map3 User
        (field "profile_image_url" string)
        (field "name" string)
        (field "screen_name" string)


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
        NewTweet string ->
            let
                decoded =
                    decodeTweet string
            in
                case decoded of
                    Ok tweet ->
                        ( List.append [ tweet ] <| List.take 100 model, Cmd.none )

                    Err _ ->
                        ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        (List.map
            (\tweet ->
                div []
                    [ text tweet.user.name
                    , br [] []
                    , text tweet.text
                    , br [] []
                    , br [] []
                    ]
            )
            model
        )


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
