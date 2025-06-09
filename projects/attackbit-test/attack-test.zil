"A Trizbort Map main file"

<VERSION ZIP>
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

"Objects"

<ROOM ARENA
    (DESC "Arena")
    (IN ROOMS)
    (FLAGS LIGHTBIT)>


<OBJECT NEIL
    (IN ARENA)
    (DESC "Neil")
    (SYNONYM NEIL)
    (FLAGS PERSONBIT)>


<OBJECT BOB
    (IN ARENA)
    (DESC "Bob")
    (SYNONYM BOB)
    (FLAGS PERSONBIT ATTACKBIT)>


<OBJECT FOO
    (IN ARENA)
    (DESC "foo")
    (SYNONYM FOO)
    (FLAGS ATTACKBIT)>


<OBJECT FROB
    (IN ARENA)
    (DESC "frob")
    (SYNONYM FROB)>

