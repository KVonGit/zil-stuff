"Door Example - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
"The Door
|An Example Game for ZILF v0.9
|by Text Misadventures
|Copyright (c) 2025
|v0.1-alpha">

<ROUTINE GO ()
  <SETG HERE ,LIVING-ROOM>
  <SETG MODE ,VERBOSE>
  <MOVE ,PLAYER ,HERE>
  <CRLF>
  <CRLF>
  <TELL "As the story begins, you hear someone (or some THING) whispering, \"">
  <ITALICIZE "get out!">
  <TELL "\"">
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <V-LOOK>
  <MAIN-LOOP>>
  
;"----------------------- UNCOMMENT TO ENABLE DEBUGGING COMMANDS ----------------------------------"
;"<COMPILATION-FLAG DEBUGGING-VERBS T>"

<INSERT-FILE "parser">

;"------------------------- UNCOMMENT TO REDEFINE ANYTHING ----------------------------------------"
;"<SET REDEFINE T>"


<ROOM LIVING-ROOM
  (IN ROOMS)
  (DESC "Living room")
  (LDESC "You should probably go out. There's nothing else to be done here.")
  (FLAGS LIGHTBIT)
  (GLOBAL FRONT-DOOR)
  (OUT TO FRONT-PORCH IF FRONT-DOOR IS OPEN)>


<ROOM FRONT-PORCH
  (IN ROOMS)
  (DESC "Front porch")
  (LDESC "You should probably go back in. There's nothing else to be done here.")
  (FLAGS LIGHTBIT)
  (GLOBAL FRONT-DOOR)
  (IN TO LIVING-ROOM IF FRONT-DOOR IS OPEN)>
  
<OBJECT FRONT-DOOR
  (IN LOCAL-GLOBALS)
  (DESC "front door")
  (DESCFCN FRONT-DOOR-DESC-R)
  (SYNONYM DOOR)
  (ADJECTIVE FRONT)
  (FLAGS OPENABLEBIT DOORBIT)>

<ROUTINE FRONT-DOOR-DESC-R ()
  <TELL "The front door stands ">
  <COND
    (<FSET? ,OPENBIT ,FRONT-DOOR>
      <TELL "open">)
    (T
      <TELL "closed">)>
  <TELL "." CR>>