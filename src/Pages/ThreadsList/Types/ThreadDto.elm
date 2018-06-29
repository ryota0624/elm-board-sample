module Pages.ThreadsList.Types.ThreadDto exposing (..)
import Types.Thread exposing (Thread)
type alias ThreadDto = {
    thread: Thread
    , commentCount: Int
  }


threadDto: Thread -> Int -> ThreadDto
threadDto = ThreadDto