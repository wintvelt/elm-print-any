import Html exposing (text, div, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Html.App exposing (beginnerProgram)
import Dict exposing (Dict)

import PrintAny

main =
  beginnerProgram { model = initialModel, view = view, update = update }

type alias Model =
  { name : String
  , someList : List Int
  , coordinates : (Int, Float)
  , counterValue : Int
  , current : Maybe Int
  , position : Position
  , weekDays : Dict Int String
  , isPresent : Bool
  }

type Position =
  NoWhere
  | Flat Int Int
  | InSpace Int Int Int

initialModel : Model
initialModel =
  { name = "Admin"
  , someList = [ 1,2,3 ]
  , coordinates = (123, 2/3)
  , counterValue = 0
  , current = Just 5
  , position = InSpace 10 20 30
  , weekDays = Dict.fromList [ ( 0,"Monday"), ( 1,"Tuesday"), ( 2,"Wednesday"), ( 3,"Thursday")]
  , isPresent = True
  }


view model =
  let
    _ = PrintAny.log model
  in
    div []
      [ button [ onClick Decrement ] [ text "-" ]
      , div [] [ text (toString model.counterValue) ]
      , button [ onClick Increment ] [ text "+" ]
      , div 
        [ style 
          [ ( "position", "absolute" )
          , ( "top", "0")
          , ( "right", "0")
          , ( "font-size", "12px")
          , ( "background-color", "lightgrey")
          , ( "padding", "8px")
          , ( "margin", "4px")
          , ( "border-radius", "4px")
          ]
        ]
        [ PrintAny.viewWithConfig
            (PrintAny.config 20 "debug-record")
            model
        ]
      ]


type Msg = Increment | Decrement


update msg model =
  case msg of
    Increment ->
      { model | counterValue = model.counterValue + 1 }

    Decrement ->
      { model | counterValue = model.counterValue - 1 }
