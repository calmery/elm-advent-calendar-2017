module Model exposing (Model, Tweet, User)


type alias Model =
    List Tweet


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
