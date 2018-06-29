module Types.Thread exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Types.Id exposing (ThreadId)
type alias Thread = {
  id: ThreadId
  , name: String
  , creatorName: String
  }

