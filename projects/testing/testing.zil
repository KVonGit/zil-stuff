"EMPTY GAME main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main loop"

<CONSTANT GAME-BANNER
"Testing|
An interactive test by Your Momma">

<ROUTINE GO ()
    <COLOR 4 2>
    <TELL
"Do you want color?" CR>
    <COND
        (<YES?>
          <COLOR 1 1>)>
    <CRLF> <CRLF>
    <TELL "INTRODUCTORY TEXT!" CR CR>
    <V-VERSION> <CRLF>
    <SETG HERE ,STARTROOM>
    <MOVE ,PLAYER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>>
<COMPILATION-FLAG DEBUGGING-VERBS T>
<INSERT-FILE "parser">


"Objects"

<OBJECT STARTROOM
    (IN ROOMS)
    (DESC "START ROOM")
    (FLAGS LIGHTBIT)
    (NORTH ,CANT-GO-THAT-WAY)
    (SOUTH "Dumbass.")>

<OBJECT BOB
  (DESC "Bob")
  (IN STARTROOM)
  (SYNONYM BOB)
  (FLAGS PERSONBIT ATTACKBIT NDESCBIT)
  (ACTION BOB-R)>

<ROUTINE BOB-R ()
  <COND
    (<VERB? TELL>
      <TELL
"Bob doesn't care about " T, PRSO " or " T, PRSI "!">)>>
  
<OBJECT NEIL
  (DESC "Neil")
  (IN STARTROOM)
  (SYNONYM NEIL)
  (LDESC "You can go in Zeke's Farmhouse or Zeke's Silo.")
  (FLAGS PERSONBIT ATTACKBIT)>