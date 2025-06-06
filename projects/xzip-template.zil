"Untitled Text Adventure - MAIN FILE"

;"Putting XZIP here results in a .z5 file."
<VERSION XZIP>
<CONSTANT RELEASEID 1>

;"Put whatever you please in GAME-BANNER. (HINT: The `|` is a CR.)"
<CONSTANT GAME-BANNER
"Untitled
|An Interactive Adventure
|by Unknown Author
|Copyright (c) 2025
|v0.1-alpha">

<ROUTINE GO ()
  ;"Replace PLACEHOLDER-ROOM with your actual starting room's name on the following line!!!"
  <SETG HERE ,PLACEHOLDER-ROOM>
  <SETG MODE ,VERBOSE>
  <MOVE ,PLAYER ,HERE>
  <CRLF>
  <CRLF>
  <TELL "INTRO TEXT GOES HERE">
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


<ROOM PLACEHOLDER-ROOM
  (IN ROOMS)
  (DESC "Room")
  (LDESC "Someone needs to rename this room and add a good description!")
  (FLAGS LIGHTBIT)>