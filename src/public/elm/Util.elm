module Util exposing (decodeTweet)

import Model exposing (..)
import Json.Decode exposing (..)


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
