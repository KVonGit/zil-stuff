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
  <SETG MODE ,VERBOSE>
  <MOVE ,PLAYER ,JAIL-CELL>
  <SETG HERE ,PLACEHOLDER-ROOM>
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

<SETG EXTRA-FLAGS (VEHBIT)>
<INSERT-FILE "parser-vehbit">

;"------------------------- UNCOMMENT TO REDEFINE STUFF -------------------------------------------"
<SET REDEFINE T>


<ROOM PLACEHOLDER-ROOM
  (IN ROOMS)
  (DESC "Room")
  (LDESC "Someone needs to rename this room and add a good description!")
  (FLAGS LIGHTBIT)>

<GLOBAL VEHICLE JAIL-CELL>

<OBJECT JAIL-CELL
  (IN PLACEHOLDER-ROOM)
  (DESC "jail cell")
  (SYNONYM JAIL CELL)
  (LDESC "A tiny cell.")
  (FLAGS CONTBIT LIGHTBIT VEHBIT OPENABLEBIT)
  (ACTION JAIL-CELL-R)>

<ROUTINE JAIL-CELL-R (RARG)
  <COND
    (<==? .RARG ,M-FLASH>
      <TELL "MFLASH!" CR>)>
  <COND
    (<VERB? ENTER>
      <SETG VEHICLE JAIL-CELL>)>>

<OBJECT SANDWICH
  (IN PLACEHOLDER-ROOM)
  (DESC "sandwich")
  (SYNONYM SANDWI SANDWICH)
  (LDESC "A sandwich lies just out of reach.")
  (FLAGS EDIBLEBIT TAKEBIT)>


<ROUTINE V-TAKE ()
    <TELL "V-TAKE" CR>
    <COND
      (<NOT <ACCESSIBLE? ,PRSO>>
        <TELL "You can't reach " T, PRSO "." CR>
        <RFALSE>)>
    <TRY-TAKE ,PRSO>
    <RTRUE>>

;"-----------------------------------------------------------------------------"
;"                                TODO                                         "
;"-----------------------------------------------------------------------------"

;"V-DROP (or PRE-DROP?) needs to check for the player's LOC, not HERE"

;"V-EXAMINE needs to add NDESCBIT to the player before examining something the "
;"  player is in, then remove NDESCBIT after"

;"V-LOOK needs to do the same."

;"DESCRIBE-OBJECT needs to check if things HERE are in/outside of the player's "
;" LOC, and add '(outside' T, LOC ')' to their DESC when printing."


;"-----------------------------------------------------------------------------"
;"                              OVERRIDES                                      "
;"-----------------------------------------------------------------------------"


<ROUTINE VISIBLE? (OBJ "AUX" P M PL)
  <TELL "VISIBLE?" CR>
  <COND 
    (<=? .OBJ ,PSEUDO-OBJECT>
      <RETURN <=? ,HERE ,PSEUDO-LOC>>)>
  <SET P <LOC .OBJ>>
  <COND
    (<0? .P>
      <RFALSE>)>
  <SET M <META-LOC .OBJ>>
  <SET PL <LOC ,WINNER>> ;"Get player's container if any"
  <COND
    (<NOT <=? .M ,HERE>>
      <COND
        (<AND .PL ;"If player is in something"
           <TELL "IN SOMETHING" CR>
              <OR <FSET? .PL ,TRANSBIT> 
                  <FSET? .PL ,OPENBIT>
                  <FSET? .PL ,SURFACEBIT>>
              <=? .M .PL>>
          <RTRUE>) ;"Can see into player's container"
        (<OR <AND <=? .P ,LOCAL-GLOBALS> <GLOBAL-IN? .OBJ ,HERE>> 
             <=? .P ,GLOBAL-OBJECTS ,GENERIC-OBJECTS>>
            <RTRUE>)
        (ELSE
          <RFALSE>)>)>
  <REPEAT ()
    <COND
      (<EQUAL? .P ,HERE ,WINNER>
        <RTRUE>)
      (<NOT <SEE-INSIDE? .P>>
        <RFALSE>)
      (ELSE
        <SET P <LOC .P>>)>>>

;"TODO - Check out UNTOUCHABLE? instead!!!"
<ROUTINE ACCESSIBLE? (OBJ "AUX" L PL)
  <TELL "ACCESSIBLE?" CR>
  <TELL "OBJ: " T .OBJ "" CR>
  <TELL "META-LOC: " T <META-LOC .OBJ> "" CR>
  <TELL "HERE: " D ,HERE CR>
  <TELL "WINNER: " T ,WINNER CR>
  <TELL "WINNER-LOC: " D <LOC ,WINNER> CR>
  <SET L <LOC .OBJ>>
  <SET PL <LOC ,WINNER>>
  
  ;"First check if player is in something"
  <COND (<AND .PL ;"Player is in a container"
              <NOT <OR <FSET? .PL ,SURFACEBIT>  ;"Not a surface"
                      <AND <FSET? .PL ,CONTBIT>  ;"Not an open container"
                           <FSET? .PL ,OPENBIT>>>>>
         <TELL "DEBUG: Can't reach outside container" CR>
         <RFALSE>)>
         
  ;"Then do the normal container checks"
  <REPEAT ()
    <COND (<AND <FSET? .L ,CONTBIT> 
                <NOT <FSET? .L ,OPENBIT>> 
                <NOT <FSET? .L ,SURFACEBIT>>>
           <RFALSE>)
          (<EQUAL? .L ,HERE ,WINNER>
           <RTRUE>)
          (ELSE
           <SET L <LOC .L>>)>>>