"Chest Example - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
"The Chest
|An Example Game for ZILF v0.9
|by Text Misadventures
|Copyright (c) 2025
|v0.1-alpha">

<ROUTINE GO ()
  <SETG HERE ,PLACEHOLDER-ROOM>
  <SETG MODE ,VERBOSE>
  <MOVE ,PLAYER ,HERE>
  <CRLF>
  <CRLF>
  <TELL "As the story begins, you hear the narrator say, \"">
  <ITALICIZE "THIS IS ONLY A TEST.">
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


<ROOM PLACEHOLDER-ROOM
  (IN ROOMS)
  (DESC "Room")
  (LDESC "Please excuse the state of this room.")
  (FLAGS LIGHTBIT)>

<OBJECT CHEST
  (IN PLACEHOLDER-ROOM)
  (DESC "chest")
  (SYNONYM CHEST)
  (FLAGS CONTBIT OPENABLEBIT)>

<OBJECT FOO
  (IN CHEST)
  (DESC "foo")
  (SYNONYM FOO)
  (FLAGS TAKEBIT)>