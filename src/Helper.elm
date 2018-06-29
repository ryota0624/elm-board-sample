module Helper exposing (..)

isAll : a -> List a -> Bool
isAll value list =  (List.filter ((==) value) list |> List.length) == (list |> List.length)