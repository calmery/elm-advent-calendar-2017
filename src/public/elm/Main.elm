port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import List
import Json.Decode exposing (..)


port newTweet : (String -> msg) -> Sub msg


port notification : String -> Cmd msg


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
                        ( List.append [ tweet ] <| List.take 100 model, notification tweet.text )

                    Err _ ->
                        ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div [ id "container" ] <|
        List.map
            (\tweet ->
                let
                    profile_image_url =
                        tweet.user.profile_image_url

                    fullname =
                        tweet.user.name

                    screen_name =
                        tweet.user.screen_name

                    body =
                        tweet.text

                    created_at =
                        tweet.created_at
                in
                    div [ class "tweet clearfix" ]
                        [ div [ class "left" ]
                            [ img [ src profile_image_url, class "avatar" ] [] ]
                        , div [ class "right" ]
                            [ div [ class "fullname" ] [ text fullname ]
                            , div [ class "username" ] [ text <| "@" ++ screen_name ]
                            , div [ class "body" ] [ text body ]
                            , div [ class "timestamp" ] [ text created_at ]
                            ]
                        ]
            )
            model


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
