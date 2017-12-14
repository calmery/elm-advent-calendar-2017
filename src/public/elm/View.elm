module View exposing (view)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (id, class, src)
import Model exposing (Model)
import Update exposing (Msg(..))
import List


view : Model -> Html Msg
view tweets =
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
            tweets
