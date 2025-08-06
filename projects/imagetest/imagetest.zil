<VERSION YZIP>
<ZIP-OPTIONS DISPLAY SOUND>
<CONSTANT RELEASEID 1>
<CONSTANT GAME-BANNER "IMAGETEST">

<INSERT-FILE "parser">

<ROUTINE GO ()
    <CRLF>
    <CRLF>
    <SETG MODE ,VERBOSE>
    <SETG HERE ,TESTING-AREA>
    <MOVE ,PLAYER ,HERE>
    <INIT-STATUS-LINE>
    <DISPLAY 2 1 1>
    <V-VERSION>
    <CRLF>
    
    <V-LOOK>
    <MAIN-LOOP>>

<ROOM TESTING-AREA
  (IN ROOMS)
  (DESC "Testing Area")
  (LDESC "You are in a nondescript testing area.")
  (FLAGS LIGHTBIT)
>

<OBJECT FROB
  (IN TESTING-AREA)
  (DESC "frob")
  (IMG 5)
  (SYNONYM FROB)
  (ACTION DISPLAY-ME-R)
>

<OBJECT BAR
  (IN TESTING-AREA)
  (DESC "bar")
  (IMG 4)
  (SYNONYM BAR)
  (ACTION DISPLAY-ME-R)
>

<OBJECT GREEN-BUTTON
  (IN TESTING-AREA)
  (DESC "green button")
  (LOOK "Just push it.")
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
  (IN TESTING-AREA)
  (DESC "blue button")
  (LOOK "Just push it.")
  (SYNONYM button)
  (ADJECTIVE blue)
  (FLAGS DEVICEBIT)
  (ACTION BLUE-BUTTON-F)
>

<ROUTINE BLUE-BUTTON-F ()
  <COND
    (<VERB? PUSH>
      <TELL "You (should) hear a bloop. (2)" CR>
      <SOUND 2 2 8>
    )
  >
>

<OBJECT YELLOW-BUTTON
  (IN TESTING-AREA)
  (DESC "yellow button")
  (LOOK "Just push it.")
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
  (IN TESTING-AREA)
  (DESC "red button")
  (LOOK "Push this button to stop any sound that is currently playing.")
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


<ROUTINE DISPLAY-ME-R ()
  <COND
    (<VERB? EXAMINE>
      <DISPLAY-IMAGE-IN-LINE>
    )
  >
>

<GLOBAL CURSOR-LOC-TBL <TABLE 0 0>>

<ROUTINE DISPLAY-IMAGE-IN-LINE ("OPT" (OBJ ,PRSO) "AUX" TABLE1 OBJ-IMG)
  <CURGET .TABLE1>
  <SET OBJ-IMG <GETP .OBJ ,P?IMG>>
  ;"TODO - ADD CHECK TO BE SURE .OBJ-IMG IS NOW DEFINED!"
  <DISPLAY .OBJ-IMG <GET ,CURSOR-LOC-TBL 0> <GET ,CURSOR-LOC-TBL 1>>
  <CRLF>
  <CRLF>
>


;<ROUTINE SHOW-IMAGE-AT-CURSOR ("OPT" (IMG-ID 0))
  <CURGET ,CURSOR-LOC-TBL>
  <DISPLAY .IMG-ID <GET ,CURSOR-LOC-TBL 1> <GET ,CURSOR-LOC-TBL 0>>
>
