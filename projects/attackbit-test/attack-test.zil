"A Trizbort Map main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main Loop"

<CONSTANT GAME-BANNER "ATTACKBIT Tester|An interactive fiction test by KV">

<ROUTINE GO ()
    <CRLF> <CRLF>
    <TELL "" CR CR>
    <V-VERSION> <CRLF>
    <SETG HERE ,ARENA>
    <MOVE ,PLAYER ,HERE>
    <V-LOOK>
    <REPEAT ()
        <COND (<PARSER>
               <PERFORM ,PRSA ,PRSO ,PRSI>
               <COND (<NOT <GAME-VERB?>>
                      <APPLY <GETP ,HERE ,P?ACTION> ,M-END>
                      <CLOCKER>)>)>
        <SETG HERE <LOC ,WINNER>>>>

<INSERT-FILE "parser">

;"------------------------- UNCOMMENT TO REDEFINE STUFF -------------------------------------------"
<SET REDEFINE T>

"Objects"

<ROOM ARENA
    (DESC "Arena")
    (IN ROOMS)
    (NORTH TO GREEN-ROOM)
    (FLAGS LIGHTBIT)>

<OBJECT BOB
    (IN ARENA)
    (DESC "Bob")
    (SYNONYM BOB)
    (FLAGS PERSONBIT ATTACKBIT)>

<OBJECT FROB
    (IN ARENA)
    (DESC "frob")
    (SYNONYM FROB)>

<ROOM GREEN-ROOM
  (IN ROOMS)
  (DESC "green room")
  (SOUTH TO ARENA)
  (FLAGS LIGHTBIT)>

<ROUTINE V-WALK ("AUX" PT PTS RM D)
  <TELL "V-WALK IS RUNNING!!!" CR>
    <COND (<NOT ,PRSO-DIR>
           <PRINTR "You must give a direction to walk in.">)
          (<0? <SET PT <GETPT ,HERE ,PRSO>>>
           <COND (<OR ,HERE-LIT <NOT <DARKNESS-F ,M-DARK-CANT-GO>>>
                  <TELL "YOU CAN'T GO THAT WAY!!!!!!" CR>)>
           <SETG P-CONT 0>
           <RTRUE>)
          (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
           <SET RM <GET/B .PT ,EXIT-RM>>)
          (<==? .PTS ,NEXIT>
           <TELL <GET .PT ,NEXIT-MSG> CR>
           <SETG P-CONT 0>
           <RTRUE>)
          (<==? .PTS ,FEXIT>
           <COND (<0? <SET RM <APPLY <GET .PT ,FEXIT-RTN>>>>
                  <SETG P-CONT 0>
                  <RTRUE>)>)
          (<==? .PTS ,CEXIT>
           <COND (<VALUE <GETB .PT ,CEXIT-VAR>>
                  <SET RM <GET/B .PT ,EXIT-RM>>)
                 (ELSE
                  <COND (<SET RM <GET .PT ,CEXIT-MSG>>
                         <TELL .RM CR>)
                        (<AND <NOT ,HERE-LIT> <DARKNESS-F ,M-DARK-CANT-GO>>
                         ;"DARKNESS-F printed a message")
                        (ELSE
                         <TELL "YOU CAN'T GO THAT WAY!!!!!!" CR>)>
                  <SETG P-CONT 0>
                  <RTRUE>)>)
          (<==? .PTS ,DEXIT>
           <COND (<FSET? <SET D <GET/B .PT ,DEXIT-OBJ>> ,OPENBIT>
                  <SET RM <GET/B .PT ,EXIT-RM>>)
                 (<SET RM <GET .PT ,DEXIT-MSG>>
                  <TELL .RM CR>
                  <SETG P-CONT 0>
                  <RTRUE>)
                 (ELSE
                  <THIS-IS-IT .D>
                  <TELL "You'll have to open " T .D
                        " first." CR>
                  <SETG P-CONT 0>
                  <RTRUE>)>)
          (ELSE
           <TELL "Broken exit (" N .PTS ")." CR>
           <SETG P-CONT 0>
           <RTRUE>)>
    <GOTO .RM>>

<ROUTINE V-ENTER ()
    <COND (<FSET? ,PRSO ,DOORBIT>
           <DO-WALK <DOOR-DIR ,PRSO>>
           <RTRUE>)
          (ELSE
           <NOT-POSSIBLE "get inside"> <RTRUE>)>>