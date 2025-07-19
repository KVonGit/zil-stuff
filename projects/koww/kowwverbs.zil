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
      <PERFORM ,V?CLIMB ,CLIFF-FACE>)
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


<VERB-SYNONYM PUT TOSS>


<ROUTINE V-TOSS-INTO ()
  <POINTLESS "Wasting your">>
  
<ROUTINE V-SING ()
  <TELL 
"Farmer Zeke is the only singer in this game! (Besides, you didn't even bring a
Koww bell!)" CR>>

<ROUTINE V-DANCE ()
  <SILLY>>
  
<SYNTAX HELP = V-HELP>

<VERB-SYNONYM HELP HINT HINTS>
  
<ROUTINE V-HELP ()
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
"You are Koww!!! The Magician!!! Not a lowly chicken!" CR>)
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
        <TELL "All you can smell is the stench of goblins." CR>)
      (<==? <LOC ,PLAYER> ,ZEKES-FARM>
        <TELL 
"You can smell the farmer nearby, as well as goblins from afar." CR>)
      (<==? <LOC ,PLAYER> ,ZEKES-FARMHOUSE ,ZEKES-SILO>
        <TELL "You can smell the farmer, but you'd rather not!" CR>)
      (<==? <LOC ,PLAYER> ,LAND-OF-NECROYAKS ,AMBUSH-POINT>
        <TELL "You can smell ">
        <COND
          (<HELD? ,GOBLIN-SPIT>
            <TELL "the stench emanating from the jar of spit and ">)>
        <TELL "Necroyaks!!!" CR>)
      (<==? <LOC ,PLAYER> ,PHOENIX-MOUNTAIN-PASS>
        <TELL 
"You smell something purple from above, and also... something resplendent...
from the east." CR>)
      (<==? <LOC ,PLAYER> ,PHOENIX-PEAK>
        <TELL "You can smell the resplendent magnificence of the Phoenix!" CR>)
      (T
        <TELL "You can smell adventure!" CR>)>>
        
<ROUTINE V-WAVE-HANDS ()
    <TELL
"You don't have hands; so, you nod and snort instead." CR>
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

<GLOBAL COULDNT-GO 0>

<ROUTINE V-WALK ("AUX" PT PTS RM D)
    <COND (<NOT ,PRSO-DIR>
           <PRINTR "You must give a direction to walk in.">)
          (<0? <SET PT <GETPT ,HERE ,PRSO>>>
           <COND (<OR ,HERE-LIT <NOT <DARKNESS-F ,M-DARK-CANT-GO>>>
                  <TELL ,CANT-GO-THAT-WAY CR>
                  <SETG COULDNT-GO 1>
                  <SETG MOVES <- ,MOVES 1>>)>
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
                         <TELL ,CANT-GO-THAT-WAY CR>)>
                  <SETG P-CONT 0>
                  <SETG COULDNT-GO 1>
                  <SETG MOVES <- ,MOVES 1>>
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
                  <SETG COULDNT-GO 1>
                  <SETG MOVES <- ,MOVES 1>>
                  <RTRUE>)>)
          (ELSE
           <TELL "Broken exit (" N .PTS ")." CR>
           <SETG P-CONT 0>
           <SETG COULDNT-GO 1>
           <SETG MOVES <- ,MOVES 1>>
           <RTRUE>)>
    <GOTO .RM>>

<SYNTAX SCORE = V-SCORE>

<ROUTINE V-SCORE ()
  <TELL "Your current score is ">
  <PRINTN ,SCORE>
  <TELL " of a possible ">
  <PRINTN ,MAX-SCORE>
  <TELL ", granting you the rank: ">
  <COND
    (<==? ,SCORE 0>
      <BOLDIZE "MOO-ZER">)
    (<L? ,SCORE 100>
      <BOLDIZE "BABY KALF">)
    (<L? ,SCORE 200>
      <BOLDIZE "MOO-STLY HARMLESS">)
    (<L? ,SCORE 420>
      <BOLDIZE "MAGICIAN">)
    (T
      <BOLDIZE "GRAND MOO-STER WIZARD">)>
  <TELL ".">
  <CRLF>>
  
<SYNTAX QUIT = KOWW-QUIT-R>

<ROUTINE KOWW-QUIT-R ()
  <TELL
"We are about to give you your score. (Press RETURN or ENTER when you are ready.) >" >
  <COND
    (<READLINE>
    <V-SCORE>
    <V-QUIT>)>>

<SYNTAX MOO = V-MOO>

<ROUTINE V-MOO ()
  <TELL "You moo." CR>>


<ROUTINE V-INVENTORY ()
    ;"check for light first"
    <COND (,HERE-LIT
           <COND (<FIRST? ,WINNER>
                  <TELL "You have:" CR>
                  <MAP-CONTENTS (I ,WINNER)
                      <TELL "  " A .I>
                      <AND <FSET? .I ,WORNBIT> <TELL " (worn)">>
                      <AND <FSET? .I ,LIGHTBIT> <TELL " (providing light)">>
                      <COND (<FSET? .I ,CONTBIT>
                             <COND (<FSET? .I ,OPENABLEBIT>
                                    <COND (<FSET? .I ,OPENBIT> <TELL " (open)">)
                                          (ELSE <TELL " (closed)">)>)>
                             <COND (<SEE-INSIDE? .I> <INV-DESCRIBE-CONTENTS .I>)>)>
                      <CRLF>>)
                 (ELSE
                  <TELL "You have no items." CR>)>)
          (ELSE
           <TELL "It's too dark to see any items you may have." CR>)>>

<ROUTINE V-THINK-ABOUT ()
    <COND (<PRSO? ,WINNER>
           <TELL "You are Koww the Magician. You can do anything!" CR>)
          (ELSE
           <TELL 
"You contemplate " T ,PRSO " for a bit, but nothing helpful comes to mind." CR>)>>

<ROUTINE V-LOOK-UNDER ()
  <TELL "That was a waste of a good turn." CR>
>

<SYNONYM IN INTO>

<SYNTAX WALKTHROUGH = V-WALKTHROUGH>

<ROUTINE V-WALKTHROUGH ()
  <TELL "[RUNNING WALKTHROUGH]" CR>
  <AND <NOT <==? ,HERE ,KOWWS-CHASM>><CRLF><GOTO ,KOWWS-CHASM>>
  <TELL "|> EAST" CR>
  <DO-WALK ,P?EAST>
  <TELL "|> ENTER SILO" CR>
  <GOTO ,ZEKES-SILO>
  <TELL "|> GIVE MILK TO ZEKE" CR>
  <PERFORM ,V?GIVE ,MILK ,ZEKE>
  <TELL "|> OUT" CR>
  <DO-WALK ,P?OUT>
  <TELL "|> ENTER FARMHOUSE" CR>
  <GOTO ,ZEKES-FARMHOUSE>
  <TELL "|> OPEN CHEST" CR>
  <PERFORM ,V?OPEN ,TREASURE-CHEST>
  <TELL "|> OUT" CR>
  <GOTO ,ZEKES-FARM>
  <TELL "|> SOUTH" CR>
  <DO-WALK ,P?SOUTH>
  <TELL "|> SOUTH" CR>
  <DO-WALK ,P?SOUTH>
  <TELL "|> GIVE NOTHING TO GUARD" CR>
  <PERFORM ,V?GIVE ,NOTHING-ITEM ,GOBLIN-GUARD>
  <TELL "|> NORTH" CR>
  <DO-WALK ,P?NORTH>
  <TELL "|> NORTH" CR>
  <DO-WALK ,P?NORTH>
  <TELL "|> PUT SOMETHING IN POND" CR>
  <GET-DUCK-TURD-R>
  <TELL "|> STAB HAYSTACK WITH PITCHFORK" CR>
  <OPEN-STATUE-CAVE-R>
  <TELL "|> SOUTH" CR>
  <DO-WALK ,P?SOUTH>
  <TELL "|> SOUTH" CR>
  <DO-WALK ,P?SOUTH>
  <TELL "| IN" CR>
  <GOTO ,INSIDE-GOBLIN-LAIR>
  <TELL "|> GIVE JADE TO KING" CR>
  <PERFORM ,V?GIVE ,JADE-STATUETTE ,GOBLIN-KING>
  <TELL "|> GIVE TURD TO KING" CR>
  <PERFORM ,V?GIVE ,DUCK-TURD ,GOBLIN-KING>
  <TELL "|> OUT" CR>
  <GOTO ,GOBLIN-LAIR>
  <TELL "|> NORTH" CR>
  <DO-WALK ,P?NORTH>
  <TELL "|> NORTH" CR>
  <DO-WALK ,P?NORTH>
  <TELL "|> NORTH" CR>
  <DO-WALK ,P?NORTH>
  <TELL "|> NORTH" CR>
  <DO-WALK ,P?NORTH>
  <TELL "|> SEARCH" CR>
  <PERFORM ,V?SEARCH-THE-ROOM>
  <TELL "|> SOUTH" CR>
  <DO-WALK ,P?SOUTH>
  <TELL "|> SOUTH" CR>
  <DO-WALK ,P?SOUTH>
  <TELL "|> EAST" CR>
  <DO-WALK ,P?EAST>
  <TELL "|> CLIMB" CR>
  <PERFORM ,V?CLIMB ,MOUNTAINS>
  <TELL "|> EAST" CR>
  <DO-WALK ,P?EAST>
  <TELL "|> GIVE FEATHER TO PHOENIX" CR>
  <PERFORM ,V?GIVE ,WING-FEATHER ,PHOENIX>
  <TELL "|> WEST" CR>
  <DO-WALK ,P?WEST>
  <TELL "|> WEST" CR>
  <DO-WALK ,P?WEST>
  <TELL "|> ENTER SILO" CR>
  <GOTO ,ZEKES-SILO>
  <TELL "|> USE PAINT" CR>
  <PERFORM ,V?USE ,PURPLE-PAINT>
  <GOTO ,ZEKES-FARM>
  <TELL "|> WEST" CR>
  <DO-WALK ,P?WEST>
  <TELL "|> USE THE FLY SCROLL" CR>
  <PERFORM ,V?USE ,FLY-SCROLL>
>