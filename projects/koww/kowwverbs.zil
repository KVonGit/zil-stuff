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