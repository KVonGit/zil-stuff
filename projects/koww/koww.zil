"KOWW main file"

<VERSION XZIP>
<CONSTANT RELEASEID 0>

"Main loop"

<CONSTANT GAME-BANNER
"The Adventures of Koww the Magician (ZIL Port)|
An Interactive Fantasy by Brian the Great|
Copyright (c) 1999 Brian the Great. All rights reserved.">

<ROUTINE GO ()
  <CRLF>
  <CRLF>
  <ITALICIZE "*** Find out if the grass is really greener on the other side of
the chasm. ***">
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <SETG HERE ,KOWWS-CHASM>
  <MOVE ,PLAYER ,HERE>
  <V-LOOK>
  <MAIN-LOOP>
>

<INSERT-FILE "parser">

; *************** COMMANDS ****************************

<SYNTAX FLY = V-FLY>

<ROUTINE V-FLY ()
  <COND
    (<AND <IN? ,PLAYER ,KOWWS-CHASM><HELD? FLY-SCROLL>>
      <CALL FINISH-R>
    )
    (T
      <TELL "That's not a spell you know.  But perhaps if you could find a
scroll -- like the ones owned by the Great Phoenix -- you could do so." CR>
    )
  >
>

<SYNTAX USE OBJECT = V-USE>

<SYNTAX USE OBJECT ON OBJECT = V-USE-ON>
<SYNTAX USE OBJECT WITH OBJECT = V-USE-ON>

<ROUTINE V-USE ()
  <TELL "That command doesn't work here. Be more specific about what you wish to
do with " T, PRSO "." CR>
>

<ROUTINE V-USE-ON ()
  <TELL "That command doesn't work here. Be more specific about what you wish to
do with " T, PRSO " and " T, PRSI "." CR>
>

<SYNTAX SPEAK TO OBJECT = V-SPEAK>

<VERB-SYNONYM SPEAK TALK>

<ROUTINE V-SPEAK ()
  <TELL "There is no reply." CR>
>

<SYNTAX SPLASH OBJECT ON OBJECT = V-SPLASH>

<ROUTINE V-SPLASH ()
   <COND
    (<AND <PRSO? ,MILK><HELD? ,MILK>>
      <TELL "Why would you do that?  Awful waste of milk." CR>
    )
    (T
      <TELL "You CAN'T DO THAT." CR>
    )
  >
>

; *************** ITEMS *******************************

<OBJECT MILK
  (IN PLAYER)
  (DESC "milk")
  (SYNONYM MILK)
  (ACTION MILK-R)
>

<ROUTINE MILK-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "todo" CR>
    )
    (<VERB? GIVE>
      <COND
        (<PRSI? ZEKE>
          <TELL "\"Well, thanks a lot, good buddy!  Well, tell ya what, why
don't I give ya this here pitchfork ta comp'n'sate ya fer yer milk.\"" CR>
          <REMOVE MILK>
          <MOVE ,PITCHFORK ,PLAYER>
        )
      >
    )
    (<VERB? DROP>
      <TELL "You can't drop your own milk." CR>
    )
  >
>

<OBJECT PITCHFORK
  (DESC "pitchfork")
  (SYNONYM PITCHF)
  (ACTION PITCHFORK-R)
>

<ROUTINE PITCHFORK-R ()
  <TELL "TODO" CR>
>

<OBJECT FLY-SCROLL
  (DESC "fly scroll")
  (SYNONYM FLY SCROLL)
  (ACTION FLY-SCROLL-R)
  (FLAGS TAKEBIT)
>

<ROUTINE FLY-SCROLL-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "TODO" CR>
    )
    (<VERB? USE>
      <CALL FINISH-R>
    )
  >
>

; *************** KOWW'S CHASM ************************

<OBJECT KOWWS-CHASM
  (IN ROOMS)
  (DESC "Koww's Chasm")
  (FLAGS LIGHTBIT)
  (ACTION KOWWS-CHASM-R)
  (FLAGS LIGHTBIT)
  (EAST TO ZEKES-FARM)
>

<ROUTINE KOWWS-CHASM-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL "You are outside in a pasture of pure, pure green.  Green as far as
the eye can see.  But you, Koww the Magician, are not satisfied.  The grass may
be even greener on the other side of the ">
      <BOLDIZE "chasm">
      <TELL "... you must know!  Also in the area is a very undramatic ">
      <BOLDIZE "sign">
      <TELL "." CR>
    )
  >
>

<OBJECT SIGN
  (DESC "sign")
  (SYNONYM SIGN)
  (IN KOWWS-CHASM)
  (FLAGS TRYTAKEBIT NDESCBIT)
  (ACTION SIGN-R)
>

<OBJECT CHASM
  (DESC "chasm")
  (FLAGS NDESCBIT)
  (SYNONYM CHASM)
  (IN KOWWS-CHASM)
  (ACTION CHASM-R)
>

<ROUTINE CHASM-R ()
  <COND
    (<VERB? TAKE>
      <TELL "Don't worry, the men in the white coats will soon be here to deal
with you." CR>
    )
    (<VERB? EXAMINE>
      <TELL "That's the chasm you simply MUST cross!  Surely the only way to
cross it is to FLY!" CR>
    )
  >
>

<ROUTINE SIGN-R ()
    <COND
      (<OR <VERB? EXAMINE><VERB? READ>>
        <TELL "It reads: '">
        <ITALICIZE "Got milk?  Come to Farmer Zeke's mag-NIFicent silo!">
        <TELL "'" CR>
      )
      (<VERB? TAKE>
        <TELL "You yank the sign out of the ground and try to fit it in your
Koww-pack.  But it just doesn't fit.  Frustrated, you put it back." CR>
      )
    >
>

; *************** ZEKE'S FARM *************************

<OBJECT ZEKES-FARM
  (IN ROOMS)
  (DESC "Zeke's Farm")
  (ACTION ZEKES-FARM-R)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (WEST TO KOWWS-CHASM)
>

<ROUTINE ZEKES-FARM-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL "You stand outside of a small ">
      <BOLDIZE "farmhouse">
      <TELL " with a ">
      <BOLDIZE "silo">
      <TELL " beside it.  There are a ">
      <BOLDIZE "haystack">
      <TELL " and a ">
      <BOLDIZE "pond">
      <TELL " here." CR CR>
    )
  >
>

<OBJECT ZEKES-FARMHOUSE-ENTRANCE
  (IN ZEKES-FARM)
  (SYNONYM FARMHO FARMHO)
  (ADJECTIVE ZEKE'S ZEKES)
  (DESC "Zeke's Farmhouse")
  (FLAGS NARTICLEBIT NDESCBIT)
  (ACTION ZEKES-FARMHOUSE-ENTRANCE-R)
>

<ROUTINE ZEKES-FARMHOUSE-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO ZEKES-FARMHOUSE>
    )
  >
>

<OBJECT ZEKES-SILO-ENTRANCE
  (IN ZEKES-FARM)
  (SYNONYM SILO)
  (ADJECTIVE ZEKE'S ZEKES)
  (DESC "Zeke's Silo")
  (FLAGS NARTICLEBIT NDESCBIT)
  (ACTION ZEKES-SILO-ENTRANCE-R)
>

<ROUTINE ZEKES-SILO-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO ZEKES-SILO>
    )
  >
>

; *************** ZEKE'S FARMHOUSE ********************

<OBJECT ZEKES-FARMHOUSE
  (IN ROOMS)
  (DESC "Zeke's Farmhouse")
  (LDESC "You're inside Farmer Zeke's rather cramped home.  No one's here at the
moment.  Perhaps you should go away.")
  (FLAGS LIGHTBIT)
  (OUT TO ZEKES-FARM)
>

<OBJECT TABLE
  (IN ZEKES-FARMHOUSE)
  (DESC "table")
  (SYNONYM TABLE)
  (FLAGS SURFACEBIT)
>


; *************** ZEKE'S SILO *************************

<OBJECT ZEKES-SILO
  (IN ROOMS)
  (SYNONYM SILO)
  (ADJECTIVE ZEKE'S ZEKES)
  (DESC "Zeke's Silo")
  (FLAGS LIGHTBIT)
  (OUT TO ZEKES-FARM)
  (ACTION ZEKES-SILO-R)
>

<ROUTINE ZEKES-SILO-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL "Gee, this place smells just like rotting feed.  Standing in the
silo, grinning like the idiot that he is, is Farmer ">
      <BOLDIZE "Zeke">
      <TELL "." CR>
    )
  >
>

<OBJECT ZEKE
  (DESC "Zeke")
  (IN ZEKES-SILO)
  (SYNONYM FARMER ZEKE)
  (FLAGS PERSONBIT NARTICLEBIT NDESCBIT)
  (ACTION ZEKE-R)
>

<ROUTINE ZEKE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "He's wearing a straw hat and at least one of his teeth is rotting
away, but he seems pleased as punch that you've arrived." CR>
    )
    (<VERB? SPEAK>
      <TELL "\"Hey there, good buddy!  Say, bein' a wizard an' all, couldja find
it in yer heart to gimme some magic milk?  I'm all out!\"" CR>
    )
    (<VERB? GIVE>
      <COND
        (<PRSO? ,MILK>
          <TELL "\"Well, thanks a lot, good buddy!  Well, tell ya what, why
don't I give ya this here pitchfork ta comp'n'sate ya fer yer milk.\"" CR>
          <REMOVE ,MILK>
          <MOVE ,PITCHFORK ,PLAYER>
        )
      >
    )
    (<VERB? ATTACK>
      <TELL "You may be an evil sorcerer, but at least you're an ETHICAL evil
sorcerer.  No killing allowed!  Especially not of idiots.  They don't know
they're idiots." CR>
    )
    (<VERB? SPLASH>
      <CALL DUMB-LOSE-R>
    )
  >
>

<ROUTINE DUMB-LOSE-R ()
  <TELL "\"Well, gee,\" says Farmer Zeke, \"I shore do like ya a lot, but I
guess there's a limit!\"" CR>
	<TELL "So saying, Zeke stabs you with his pitchfork." CR>
  <CRLF>
	<JIGS-UP ,LOSE-TEXT>
  <CRLF>
  <V-QUIT>
>

; *************** GOBLIN TRAIL ************************

; *************** GOBLIN LAIR *************************

; *************** INSIDE THE GOBLIN LAIR **************

; *************** LAND OF THE NECROYAKS ***************

; *************** AMBUSH POINT ************************

; *************** PHOENIX MOUNTAIN PASS ***************

; *************** PHOENIX PEAK ************************

; *************** END OF ROOM DESCRIPTIONS ************

<GLOBAL WIN-TEXT "Congratulations, you have found out that you were better off
where you started anyway.  The grass here is brown and crackly.  Too bad!
 And... OH NO!  Now you're trapped here, alone with the NecroYaks!  Stay tuned
for \"The Adventures of Koww the Magician II -- Escape from the NecroYaks!\"">

<GLOBAL LOSE-TEXT "Idiot.  You die.  HA HA HA HA HA!">

<ROUTINE FINISH-R ()
  <COND
    (<HELD? FLY-SCROLL>
      <CALL END-R>
    )
    (T
      <TELL "Maybe you'll find it someday, but you don't have it today.  You
stupid cow." CR>
    )
  >
>

<ROUTINE END-R ()
  <TELL "You fly up and over the chasm!" CR CR>
  <TELL ,WIN-TEXT>
  <V-QUIT>
>

; *** TEXT ROUTINES ***

<ROUTINE BOLDIZE (TEXT)
  <HLIGHT 2>
  <TELL .TEXT>
  <HLIGHT 0>
>