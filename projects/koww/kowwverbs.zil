"kowwverbs"

;HACK
;"<SYNTAX EAT OBJECT (FIND EDIBLEBIT) (TAKE HAVE HELD CARRIED ON-GROUND IN-ROOM) = V-EAT>"
<SYNTAX EAT OBJECT (FIND EDIBLEBIT) (TAKE HELD CARRIED ON-GROUND IN-ROOM) = V-EAT>

; ************************* COMMANDS *******************************************

<SYNTAX FLY = V-FLY>

<ROUTINE V-FLY ()
  <COND
    (<HELD? FLY-SCROLL>
      <COND
        (<IN? ,PLAYER ,KOWWS-CHASM>
          <CALL FINISH-R>)
        (T
          <TSD>)>)
    (T
      <TELL 
"That's not a spell you know.  But perhaps if you could find a scroll -- like
the ones owned by the Great Phoenix -- you could do so." CR>)>>

<SYNTAX USE OBJECT = V-USE>

<SYNTAX USE OBJECT ON OBJECT = V-USE-ON>
<SYNTAX USE OBJECT WITH OBJECT = V-USE-ON>

<CONSTANT NO-QUEST-USE-LIE 
"That command doesn't work here. Be more specific about what you wish to do
with">

<ROUTINE V-USE ()
  <TELL ,NO-QUEST-USE-LIE " " T, PRSO "." CR>>

<ROUTINE V-USE-ON ()
  <TELL ,NO-QUEST-USE-LIE " " T, PRSO " and " T, PRSI "." CR>>

<SYNTAX SPEAK TO OBJECT = V-SPEAK>

<VERB-SYNONYM SPEAK TALK>

<ROUTINE V-SPEAK ()
  <TELL "There is no reply." CR>>

<SYNTAX SPLASH OBJECT ON OBJECT = V-SPLASH>

<ROUTINE V-SPLASH ()
   <COND
    (<AND <PRSO? ,MILK><HELD? ,MILK>>
      <TELL "Why would you do that?  Awful waste of milk." CR>)
    (T
      <TELL "You can't do that." CR>
    )>>

<SYNTAX CAST OBJECT (FIND SPELLBIT) = V-CAST>

<ROUTINE V-CAST ()
  <TELL 
"You don't know that spell." CR>>

<SYNTAX DIG OBJECT WITH OBJECT = V-DIG>

<ROUTINE V-DIG ()
  <TELL 
"You can't dig " T, PRSI " with " T, PRSO ".">>

<SYNTAX CLIMB = V-CLIMB-MOD>

<ROUTINE V-CLIMB-MOD ()
  <COND
    (<==? <LOC ,PLAYER> ,PHOENIX-MOUNTAIN-PASS>
      <PERFORM ,V?CLIMB ,MOUNTAINS>)
    (<==? <LOC ,PLAYER> ,GOBLIN-TRAIL>
      <PERFORM ,V?CLIMB ,CLIFF>)
    (T
      <V-CLIMB>)>>

<SYNTAX STAB OBJECT WITH OBJECT = V-STAB>

<VERB-SYNONYM STAB STICK POKE JAB PROD>

<ROUTINE V-STAB ()
  <V-ATTACK>>

<SYNTAX PAINT OBJECT = V-PAINT>

<ROUTINE V-PAINT ()
  <COND
    (<HELD? ,PURPLE-PAINT>
      <COND
        (<PRSO? ,PLAYER>
          <PURPLE-USE-R>)
        (T
          <POINTLESS "Painting">)>)
    (T
      <TELL 
"You don't have any paint." CR>)>>

<SYNTAX DROP OBJECT INTO OBJECT = V-TOSS-INTO>
<SYNTAX PUT OBJECT INTO OBJECT = V-TOSS-INTO>
<SYNTAX THROW OBJECT INTO OBJECT = V-TOSS-INTO>
<SYNTAX PITCH OBJECT INTO OBJECT = V-TOSS-INTO>
<SYNTAX TOSS OBJECT INTO OBJECT = V-TOSS-INTO>
<SYNTAX THROW OBJECT IN OBJECT = V-TOSS-INTO>
<SYNTAX PITCH OBJECT IN OBJECT = V-TOSS-INTO>
<SYNTAX TOSS OBJECT IN OBJECT = V-TOSS-INTO>

<SYNONYM IN INTO>

<ROUTINE V-TOSS-INTO ()
  <POINTLESS "Wasting your">>
  
<ROUTINE V-SING ()
  <TELL 
"Farmer Zeke is the only singer in this game! (Besides, there isn't even a Koww
bell in this game!)" CR>>

<ROUTINE V-DANCE ()
  <SILLY>>
  
<SYNTAX HINTS = V-HINTS>

<SYNONYM HINTS HINT HELP>
  
<ROUTINE V-HINTS ()
  <TELL
"If you're really stuck, consult your Koww manual, CONTEMPLATE SOMETHING,
peruse the feelies, or just check out the walkthrough on IFDB." CR>>

<SYNTAX CROSS OBJECT = V-CROSS>

<ROUTINE V-CROSS ()
  <COND
    (<==? ,PRSO ,CHASM>
      <TELL "(flying)" CR>
      <PERFORM ,V?FLY>
      <RTRUE>)
    (<==? ,PRSO ,ROAD>
      <TELL
"Why did the magical cow cross the road?" CR>)
    (T
      <TELL
"You can't cross " T, PRSO "." CR>)>>

<GLOBAL PRINTED-RHETORICAL <>>

<ROUTINE V-YES ()
  <COND
    (<==? ,PRINTED-RHETORICAL ,T>
      <SETG PRINTED-RHETORICAL <>>
      <RHETORICAL>
      <RTRUE>)
    (T
      <TELL "You sound rather positive!" CR>)>>

<ROUTINE V-NO ()
  <COND
    (<==? ,PRINTED-RHETORICAL ,T>
      <SETG PRINTED-RHETORICAL <>>
      <RHETORICAL>
      <RTRUE>)
    (T
      <TELL "You sound rather negative." CR>)>>
  
<ROUTINE V-EAT ()
    <COND (<PRSO? ,WINNER> <TSD> <RTRUE>)
          (<FSET? ,PRSO ,PERSONBIT> <YOU-MASHER> <RTRUE>)
          (<FSET? ,PRSO ,EDIBLEBIT>
           <REMOVE ,PRSO>
           <COND (<SHORT-REPORT?> <TELL "Eaten." CR>)
                 (ELSE <TELL "You devour " T ,PRSO "." CR>)>)
          (ELSE <TELL 
"That doesn't look appetizing.  You chew your cud instead." CR>)>>

<SYNTAX SMELL = V-SMELL-ROOM>

<VERB-SYNONYM SMELL SNIFF>

<ROUTINE V-SMELL-ROOM ()
    <COND
      (<==? <LOC ,PLAYER>,GOBLIN-TRAIL ,GOBLIN-LAIR ,INSIDE-GOBLIN-LAIR>
        <TELL "All you can smell is the stench of goblins.">)
      (T
        <TELL "You smell nothing unexpected." CR>)>>
        
<ROUTINE V-WAVE-HANDS ()
    <TELL
"You don't have any hands." CR>
    <RTRUE>>

           
<ROUTINE HAVE-TAKE-CHECK-TBL (TBL OPTS "AUX" MAX O N ORM)
  <SET MAX <GETB .TBL 0>>
  ;"Attempt implicit take if WINNER isn't directly holding the objects"
  <COND (<BTST .OPTS ,SF-TAKE>
   <DO (I 1 .MAX)
     <COND (<SHOULD-IMPLICIT-TAKE? <GET/B .TBL .I>>
      <TELL "[taking ">
      <SET N <LIST-OBJECTS .TBL ,SHOULD-IMPLICIT-TAKE? <+ ,L-PRSTABLE ,L-THE>>>
      <TELL "]" CR>
      <REPEAT ()
          <COND (<SHOULD-IMPLICIT-TAKE? <SET O <GET/B .TBL .I>>>
                 <COND (<NOT <TRY-TAKE .O T>>
                        <COND (<G? .N 1>
                               <SET ORM ,REPORT-MODE>
                               <SETG REPORT-MODE ,SHORT-REPORT>
                               <TELL D .O ": ">
                               <TRY-TAKE .O>
                               <SETG REPORT-MODE .ORM>)
                              (ELSE
                               <TRY-TAKE .O>)>
                        <RFALSE>)>)>
          <COND (<IGRTR? I .MAX> <RETURN>)>>
          <RETURN>)>>)>
  ;"WINNER must (indirectly) hold the objects if SF-HAVE is set"
  <COND (<BTST .OPTS ,SF-HAVE>
   <DO (I 1 .MAX)
     <COND (<FAILS-HAVE-CHECK? <GET/B .TBL .I>>
      <COND
        (<PRSO? ,KOWW-PACK>
          <RTRUE>)
        (T
          <TELL "You aren't holding ">
          <LIST-OBJECTS .TBL ,FAILS-HAVE-CHECK? <+ ,L-PRSTABLE ,L-THE ,L-OR>>
          <TELL ", silly cow." CR>
          <SETG P-CONT 0>
          <RFALSE>)>)>>)>
  <RTRUE>>


<ROUTINE HAVE-TAKE-CHECK (OBJ OPTS)
    <COND
      (<PRSO? ,KOWW-PACK>
        <RTRUE>)>
    ;"Attempt implicit take if WINNER isn't directly holding the object"
    <COND (<BTST .OPTS ,SF-TAKE>
           <COND (<SHOULD-IMPLICIT-TAKE? .OBJ>
                  <TELL "[taking " T .OBJ "]" CR>
                  <COND (<NOT <TRY-TAKE .OBJ T>>
                         <TRY-TAKE .OBJ>
                         <RFALSE>)>)>)>
    ;"WINNER must (indirectly) hold the object if SF-HAVE is set"
    <COND (<BTST .OPTS ,SF-HAVE>
           <COND (<FAILS-HAVE-CHECK? .OBJ>
                  <TELL "You aren't holding " T .OBJ "." CR>
                  <SETG P-CONT 0>
                  <RFALSE>)>)>
    <RTRUE>>

<SYNTAX WALK TO OBJECT (FIND DOORBIT) (IN-ROOM) = V-ENTER>
<SYNTAX WALK INTO OBJECT (FIND DOORBIT) (IN-ROOM) = V-ENTER>

<SYNTAX SCORE = V-SCORE>

<ROUTINE V-SCORE ()
  <TELL "Your current score is ">
  <PRINTN ,SCORE>
  <TELL " of a possible ">
  <PRINTN ,MAX-SCORE>
  <TELL "." CR>>
  
<SYNTAX QUIT = KOWW-QUIT-R>

<ROUTINE KOWW-QUIT-R ()
  <TELL
"We are about to give you your score. (Press RETURN or ENTER when you
are ready.) >" >
  <COND
    (<READLINE>
    <V-SCORE>
    <V-QUIT>)>>