module Types.Validation exposing (..)
import Html exposing (Html)
import Html.Events as Events
import Html.Attributes as Attr

type ValidationMessage =
  IsBlank { fieldName: String }
  | IsLongText { fieldName : String }
  | IsShortText { fieldName: String }
messageToText : ValidationMessage -> String 
messageToText message = case message of
  IsBlank {fieldName} ->  fieldName ++ "がからです"
  IsLongText {fieldName} ->  fieldName ++ "が最大文字数を越えています"
  IsShortText {fieldName} ->  fieldName ++ "が下限文字数を下回っています"
type alias Validator value subject = {
    getSubject :  (value -> subject)
    , check: (subject -> Bool)
    , failureMessage: ValidationMessage 
    }

ifBlank : String -> (value -> String) -> Validator value String
ifBlank fieldName getSubject = {
    getSubject = getSubject
    , check = \text -> 1 > (text |> String.length)
    , failureMessage = IsBlank {fieldName = fieldName}
  }

ifTextIsLong : String -> (value -> String) -> Int -> Validator value String
ifTextIsLong fieldName getSubject maxLength = {
    getSubject = getSubject
    , check = \text -> (text |> String.length) > maxLength
    , failureMessage = IsLongText {fieldName = fieldName} 
  }

ifTextIsShort : String -> (value -> String) -> Int -> Validator value String
ifTextIsShort fieldName getSubject minLength = {
    getSubject = getSubject
    , check = \text -> minLength > (text |> String.length)
    , failureMessage = IsShortText {fieldName = fieldName} 
  }

validate: value -> Validator value subject -> Maybe ValidationMessage
validate value {getSubject, check, failureMessage}  =
  if check <| getSubject value then
    failureMessage |> Just
  else Nothing

run : List (Validator value subject) -> value -> Maybe ValidationMessage
run validators value = validators 
    |> List.filterMap (validate value)
    |> List.head 


validationForm: Bool -> List ((Html msg, Maybe ValidationMessage)) -> msg -> Html msg
validationForm disable formAndValidationResults onSubmit =
  let
    forms = formAndValidationResults |> List.map (Tuple.first)
    failureResults = formAndValidationResults |> List.filterMap (Tuple.second)
  in
    Html.div [] (
      forms ++ [
        Html.button 
          [ 
            Events.onClick onSubmit
            , Attr.disabled 
                <| not 
                <| List.isEmpty 
                <| failureResults 
          ] []
        , if disable then Html.text "" else Html.div [] (failureResults |> List.map (messageToText >> Html.text))
      ]
    )