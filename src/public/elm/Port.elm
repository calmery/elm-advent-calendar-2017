port module Port exposing (newTweet, notification)


port newTweet : (String -> msg) -> Sub msg


port notification : String -> Cmd msg
