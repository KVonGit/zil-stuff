"meta - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
"meta
|An Interactive fiction
|By Text Misadventures"
>

<ROUTINE GO ()
  <SETG MODE ,VERBOSE>
  <SETG HERE ,ROOM>
  <MOVE ,PLAYER ,HERE>
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <V-LOOK>
  <MAIN-LOOP>
>
  
;"----------------------- UNCOMMENT TO ENABLE DEBUGGING COMMANDS ----------------------------------"
;"<COMPILATION-FLAG DEBUGGING-VERBS T>"

;"----------------------- UNCOMMENT TO ADD FLAGS --------------------------------------------------"
<SETG EXTRA-FLAGS (VEHBIT NALLBIT)>


<INSERT-FILE "parser">

;"------------------------- UNCOMMENT TO REDEFINE STUFF -------------------------------------------"
<SET REDEFINE T>


;"==================================== GAME WORLD ================================================="

<OBJECT ROOM
  (DESC "ROOM")
  (FLAGS LIGHTBIT)
  (ACTION ROOM-R)
>

<ROUTINE ROOM-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"ONE"><PRINTC 124><TELL "TWO" CR>
    )
  >
>