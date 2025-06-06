"Untitled Text Adventure - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
  "Vehicle Test 2
|This is only a test.
|by KV
|Copyright (c) 2025
|v0.1-alpha">

<ROUTINE GO ()
  <SETG HERE ,PLACEHOLDER-ROOM>
  <SETG MODE ,VERBOSE>
  <MOVE ,PLAYER ,HERE>
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <V-LOOK>
  <MAIN-LOOP>>
  
;"----------------- UNCOMMENT TO ENABLE DEBUGGING COMMANDS ----------------------------------------"
;"<COMPILATION-FLAG DEBUGGING-VERBS T>"
;"-------------------------------------------------------------------------------------------------"

<INSERT-FILE "parser">

;"----------------- UNCOMMENT TO ALLOW REDEFINING ANYTHING ----------------------------------------"
;"<SET REDEFINE T>"
;"-------------------------------------------------------------------------------------------------"


<ROOM PLACEHOLDER-ROOM
  (IN ROOMS)
  (DESC "Room")
  (LDESC "Someone needs to rename this room and add a good description!")
  (FLAGS LIGHTBIT)>

<OBJECT CAR
  (IN PLACEHOLDER-ROOM)
  (DESC "car")
  (SYNONYM CAR)
  (FLAGS CONTBIT OPENABLEBIT VEHBIT)>