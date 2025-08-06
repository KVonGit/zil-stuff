<VERSION XZIP>
<ZIP-OPTIONS SOUND>
<CONSTANT RELEASEID 1>
<CONSTANT GAME-BANNER "PRESS A BUTTON">

<INSERT-FILE "parser">

<ROUTINE GO ()
    <CRLF>
    <CRLF>
    <SETG MODE ,VERBOSE>
    <SETG HERE ,SOUND-BOOTH>
    <MOVE ,PLAYER ,HERE>
    <INIT-STATUS-LINE>
    <V-VERSION>
    <CRLF>
    <V-LOOK>
    <MAIN-LOOP>>

<ROOM SOUND-BOOTH
  (IN ROOMS)
  (DESC "Sound Booth")
  (LDESC "You are in a small sound booth.")
  (FLAGS LIGHTBIT)
>

<OBJECT GREEN-BUTTON
  (IN SOUND-BOOTH)
  (DESC "green button")
  (SYNONYM button)
  (ADJECTIVE green)
  (FLAGS DEVICEBIT)
  (ACTION GREEN-BUTTON-F)
>

<ROUTINE GREEN-BUTTON-F ()
  <COND
    (<VERB? PUSH>
      <TELL "You (should) hear a bleep. (1)" CR>
      <SOUND 1>
    )
  >
>

<OBJECT BLUE-BUTTON
  (IN SOUND-BOOTH)
  (DESC "blue button")
  (SYNONYM button)
  (ADJECTIVE blue)
  (FLAGS DEVICEBIT)
  (ACTION BLUE-BUTTON-F)
>

<ROUTINE BLUE-BUTTON-F ()
  <COND
    (<VERB? PUSH>
      <TELL "You (should) hear a bloop. (2)" CR>
      <SOUND 2 2 8 YELLOW-CALLBACK>
    )
  >
>

<OBJECT YELLOW-BUTTON
  (IN SOUND-BOOTH)
  (DESC "yellow button")
  (SYNONYM BUTTON)
  (ADJECTIVE YELLOW)
  (FLAGS DEVICEBIT)
  (ACTION YELLOW-BUTTON-R)
>

<ROUTINE YELLOW-BUTTON-R ()
  <COND
    (<VERB? PUSH>
      <TELL "You (should) hear a DUMMY talking. (3)" CR>
      <SOUND 3 2 8>
    )
  >
>

<OBJECT RED-BUTTON
  (IN SOUND-BOOTH)
  (DESC "red button")
  (SYNONYM button)
  (ADJECTIVE red)
  (FLAGS DEVICEBIT)
  (ACTION RED-BUTTON-F)
>

<ROUTINE RED-BUTTON-F ()
  <COND
    (<VERB? PUSH>
      <TELL "All sounds should now stop, if any are playing. (0 3)" CR>
      <SOUND 0 3>
    )
  >
>
