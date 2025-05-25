"KOWW main file"

<VERSION XZIP>
<CONSTANT RELEASEID 0>

<CONSTANT GAME-BANNER
"The Adventures of Koww the Magician (ZIL Port)|
An Interactive Fantasy by Brian the Great|
Copyright (c) 1999 Brian the Great. All rights reserved.|
v0.1.0 alpha">

<ROUTINE GO ()
  <CRLF>
  <CRLF>
  <ITALICIZE 
"*** Find out if the grass is really greener on the other side of the chasm. 
***">
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <SETG HERE ,KOWWS-CHASM>
  <MOVE ,PLAYER ,HERE>
  <V-LOOK>
  <MAIN-LOOP>>

<INSERT-FILE "parser">

<CONSTANT DEBUG T>
<CONSTANT DEBUGGING-VERBS T>

;HACK
;"<SYNTAX EAT OBJECT (FIND EDIBLEBIT) (TAKE HAVE HELD CARRIED ON-GROUND IN-ROOM) = V-EAT>"
<SYNTAX EAT OBJECT (FIND EDIBLEBIT) (TAKE HELD CARRIED ON-GROUND IN-ROOM) = V-EAT>

; ************************* COMMANDS *******************************************

<SYNTAX FLY = V-FLY>

<ROUTINE V-FLY ()
  <COND
    (<AND <IN? ,PLAYER ,KOWWS-CHASM><HELD? FLY-SCROLL>>
      <CALL FINISH-R>    )
    (T
      <TELL 
"That's not a spell you know.  But perhaps if you could find a scroll -- like
the ones owned by the Great Phoenix -- you could do so." CR>
    )>>

<SYNTAX USE OBJECT = V-USE>

<SYNTAX USE OBJECT ON OBJECT = V-USE-ON>
<SYNTAX USE OBJECT WITH OBJECT = V-USE-ON>

<ROUTINE V-USE ()
  <TELL 
"That command doesn't work here. Be more specific about what you wish to do with
" T, PRSO "." CR>>

<ROUTINE V-USE-ON ()
  <TELL 
"That command doesn't work here. Be more specific about what you wish to do with
" T, PRSO " and " T, PRSI "." CR>>

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
      <TELL "You CAN'T DO THAT." CR>
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
      <TELL 
"You don't have any paint!" CR>)
    (<PRSO? ,PLAYER>
      <PURPLE-COW-R>)
    (T
      <POINTLESS "Painting">)>>

; ************************* ITEMS **********************************************

<ROUTINE QUEST-TWO-R ()
  <COND
    (<==? ,PRSA ,V?EXAMINE>
      <TELL 
"About what you'd expect." CR>)
    (<==? ,PRSA ,V?DROP>
      <TELL
"That's not something you should drop." CR>)
    (T
      <CRLF>
      <TELL
"*** TODO - QUEST 2 HAD NO BUILT-IN INVENTORY FUNCTIONALITY. WE COULD NOT
INTERACT WITH QUEST 2 'ITEMS', EXCEPT FOR 'USE OBJECT' AND 'GIVE OBJECT TO
OBJECT'. ***" CR>)>>

<OBJECT MILK
  (IN PLAYER)
  (DESC "milk")
  (SYNONYM MILK)
  (ACTION MILK-R)
  (FLAGS NARTICLEBIT)>

<ROUTINE MILK-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? GIVE>
      <COND
        (<PRSI? ZEKE>
          <TELL 
"\"Well, thanks a lot, good buddy!  Well, tell ya what, why don't I give ya this
here pitchfork ta comp'n'sate ya fer yer milk.\"" CR>
          <REMOVE ,MILK>
          <MOVE ,PITCHFORK ,PLAYER>
        )>)>>

<OBJECT PITCHFORK
  (DESC "pitchfork")
  (SYNONYM PITCHF PITCHFORK)
  (ACTION PITCHFORK-R)>

<ROUTINE PITCHFORK-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? USE-ON DIG>
      <COND
        (<OR 
          <AND <VERB? USE-ON><PRSI? ,HAYSTACK>>
          <AND <VERB? DIG><PRSO? ,HAYSTACK>>>
            <CALL OPEN-STATUE-CAVE-R>)>)>>

<OBJECT FLY-SCROLL
  (DESC "the fly scroll")
  (SYNONYM FLY SCROLL SPELL)
  (ADJECTIVE FLY)
  (ACTION FLY-SCROLL-R)
  (FLAGS TAKEBIT NARTICLEBIT SPELLBIT)>

<ROUTINE FLY-SCROLL-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>
    )
    (<VERB? USE CAST>
      <CALL FINISH-R>)>>


<OBJECT WING-FEATHER
  (DESC "wing feather")
  (SYNONYM WING FEATHER)
  (ADJECTIVE WING)
  (FLAGS TAKEBIT)
  (ACTION WING-FEATHER-R)>

<ROUTINE WING-FEATHER-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>
    )>>

<OBJECT JADE-STATUETTE
  (DESC "jade statuette")
  (SYNONYM JADE STATUETTE STATUE)
  (ADJECTIVE JADE)
  (FLAGS TAKEBIT)
  (ACTION JADE-STATUETTE-R)>

<ROUTINE JADE-STATUETTE-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? GIVE>
      <COND
        (<PRSI? ,GOBLIN-KING>
          <GIFT-OF-KING-R>)>)>>

<OBJECT GOBLIN-SPIT
  (DESC "goblin spit")
  (SYNONYM SPIT)
  (ADJECTIVE GOBLIN)
  (FLAGS TAKEBIT NARTICLEBIT)
  (ACTION GOBLIN-SPIT-R)>

<ROUTINE GOBLIN-SPIT-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)>>

<OBJECT SOMETHING-ITEM
  (DESC "something")
  (SYNONYM SOMETHING)
  (FLAGS TAKEBIT NARTICLEBIT)
  (ACTION SOMETHING-ITEM-R)>

<ROUTINE SOMETHING-ITEM-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? USE-ON PUT-IN>
      <COND
        (<PRSI? ,POND>
          <CALL GET-DUCK-TURD-R>)>)>>

<OBJECT NOTHING-ITEM
  (DESC "nothing")
  (SYNONYM NOTHING)
  (FLAGS TAKEBIT NARTICLEBIT)
  (ACTION NOTHING-ITEM-R)>

<ROUTINE NOTHING-ITEM-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>
    )
    (<VERB? GIVE>
      <COND
        (<PRSI? ,GOBLIN-GUARD>
          <CALL SECRET-ONE-R>)>)>>

<OBJECT DUCK-TURD
  (DESC "duck turd")
  (SYNONYM TURD)
  (ADJECTIVE DUCK)
  (FLAGS TAKEBIT)
  (ACTION DUCK-TURD-R)>

<ROUTINE DUCK-TURD-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? GIVE>
      <COND
        (<PRSI? ,GOBLIN-KING>
          <OTHER-GIFT-R>)>)>>

<OBJECT GRAPPLING-HOOK
  (DESC "grappling hook")
  (SYNONYM HOOK)
  (ADJECTIVE GRAPPLING)
  (FLAGS TAKEBIT)
  (ACTION GRAPPLING-HOOK-R)>

<ROUTINE GRAPPLING-HOOK-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? USE>
      <COND
        (<==? <LOC ,PLAYER> ,MOUNTAINS>
          <CLIMB-THEM-R>)>)
    (<VERB? USE-ON>
      <COND
        (<PRSO? ,MOUNTAINS>
          <CLIMB-THEM-R>)>)>>

<OBJECT PURPLE-PAINT
  (DESC "purple paint")
  (SYNONYM PURPLE PAINT)
  (ADJECTIVE PURPLE)
  (FLAGS TAKEBIT NARTICLEBIT)
  (ACTION PURPLE-PAINT-R)>

<ROUTINE PURPLE-PAINT-R ()
  <COND
    (<VERB? EXAMINE DROP>
      <QUEST-TWO-R>)
    (<VERB? USE>
      <COND
        (<==? <LOC ,PLAYER> ,ZEKES-SILO>
          <PURPLE-USE-R>)>)>>

<ROUTINE PURPLE-USE-R ()
  <COND
    (<HELD? ,PURPLE-PAINT>
      <PURPLE-COW-R>)
    (T
      <TELL
"You don't know where that is." CR>
    )>>

<ROUTINE PURPLE-COW-R ()
  <REMOVE ,PURPLE-PAINT>
  <TELL
"You spread the purple paint on yourself.  Suddenly Farmer Zeke bursts into
song!" CR>
  <TELL "\"">
  <ITALICIZE 
"I never saw a purple cow, and I never hope to see one; but I can tell you
anyhow, I'd rather see than be one!">
  <TELL "\"" CR>
  <TELL
"Wonderful!  You have just activated the scenario's secret feature!  That's it. 
Return to your home.  There's nothing more to do here." CR>>


; ************************* KOWW'S CHASM ***************************************

<OBJECT KOWWS-CHASM
  (IN ROOMS)
  (DESC "Koww's Chasm")
  (FLAGS LIGHTBIT)
  (ACTION KOWWS-CHASM-R)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (EAST TO ZEKES-FARM)>

<ROUTINE KOWWS-CHASM-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL 
"You are outside in a pasture of pure, pure green.  Green as far as the eye can
see.  But you, Koww the Magician, are not satisfied.  The grass may be even
greener on the other side of the ">
      <BOLDIZE "chasm">
      <TELL "... you must know!  Also in the area is a very undramatic ">
      <BOLDIZE "sign">
      <TELL "." CR CR>)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "east">
      <TELL "." CR>)>>

<OBJECT CHASM-SIGN
  (DESC "sign")
  (SYNONYM SIGN)
  (IN KOWWS-CHASM)
  (FLAGS TRYTAKEBIT NDESCBIT)
  (ACTION CHASM-SIGN-R)>

<OBJECT CHASM
  (DESC "chasm")
  (FLAGS NDESCBIT)
  (SYNONYM CHASM)
  (IN KOWWS-CHASM)
  (ACTION CHASM-R)>

<ROUTINE CHASM-SIGN-R ()
    <COND
      (<OR <VERB? EXAMINE><VERB? READ>>
        <TELL "It reads: '">
        <ITALICIZE "Got milk?  Come to Farmer Zeke's mag-NIFicent silo!">
        <TELL "'" CR>)
      (<VERB? TAKE>
        <TELL 
"You yank the sign out of the ground and try to fit it in your Koww-pack.  But
it just doesn't fit.  Frustrated, you put it back." CR>)>>

<ROUTINE CHASM-R ()
  <COND
    (<VERB? TAKE>
      <TELL 
"Don't worry, the men in the white coats will soon be here to deal with you.|">)
    (<VERB? EXAMINE>
      <TELL 
"That's the chasm you simply MUST cross!  Surely the only way to cross it is to
FLY!" CR>)>>

; ************************* ZEKE'S FARM ****************************************

<OBJECT ZEKES-FARM
  (IN ROOMS)
  (DESC "Zeke's Farm")
  (ACTION ZEKES-FARM-R)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (WEST TO KOWWS-CHASM)
  (SOUTH TO GOBLIN-TRAIL)
  (EAST TO PHOENIX-MOUNTAIN-PASS)
  (NORTH TO LAND-OF-NECROYAKS)>

<ROUTINE ZEKES-FARM-R (RARG)
  <COND
    (<==? .RARG ,M-FLASH>
      <TELL "You stand outside of a small ">
      <BOLDIZE "farmhouse">
      <TELL " with a ">
      <BOLDIZE "silo">
      <TELL " beside it.  There is a ">
      <BOLDIZE "haystack">
      <TELL " and a ">
      <BOLDIZE "pond">
      <TELL " here." CR CR>
      <TELL "You can go ">
      <BOLDIZE "west">
      <TELL ", ">
      <BOLDIZE "south">
      <TELL ", ">
      <BOLDIZE "east">
      <TELL ", or ">
      <BOLDIZE "north">
      <TELL "." CR>)>>

<OBJECT ZEKES-FARMHOUSE-ENTRANCE
  (IN ZEKES-FARM)
  (SYNONYM FARMHO FARMHOUSE)
  (ADJECTIVE ZEKE'S ZEKES)
  (DESC "Zeke's Farmhouse")
  (FLAGS NARTICLEBIT NDESCBIT)
  (ACTION ZEKES-FARMHOUSE-ENTRANCE-R)>

<ROUTINE ZEKES-FARMHOUSE-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO ZEKES-FARMHOUSE>)>>

<OBJECT ZEKES-SILO-ENTRANCE
  (IN ZEKES-FARM)
  (SYNONYM SILO)
  (ADJECTIVE ZEKE'S ZEKES)
  (DESC "Zeke's Silo")
  (FLAGS NARTICLEBIT NDESCBIT DOORBIT)
  (ACTION ZEKES-SILO-ENTRANCE-R)>

<ROUTINE ZEKES-SILO-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO ZEKES-SILO>
    )>>

<OBJECT HAYSTACK
  (DESC "haystack")
  (SYNONYM HAY HAYSTA HAYSTACK)
  (IN ZEKES-FARM)
  (FLAGS NDESCBIT TAKEBIT TRYTAKEBIT EDIBLEBIT)
  (ACTION HAYSTACK-R)>

<ROUTINE HAYSTACK-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"About what you'd expect from a haystack.  It's made of... HAY!  You munch on it
for a while." CR>)
    (<VERB? EAT TAKE>
      <TELL 
"You take a bite of the haystack.  Yummy... tastes just like chicken!" CR>
    )>>

<ROUTINE OPEN-STATUE-CAVE-R ()
  <TELL
"You stab the pitchfork into the haystack.  Lo and behold, the haystack falls
down into a hole in the ground!  Inside the hole is a jade statuette, which you
take." CR>
  <REMOVE ,PITCHFORK>
  <MOVE ,JADE-STATUETTE ,PLAYER>>

<OBJECT POND
  (DESC "pond")
  (SYNONYM POND WATER)
  (IN ZEKES-FARM)
  (FLAGS NDESCBIT TAKEBIT TRYTAKEBIT EDIBLEBIT)
  (ACTION POND-R)>

<ROUTINE POND-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"A nice, placid pond full of little tiny duckies.  Ooo, how cute!  If you were
carnivorous, they'd make you hungry." CR>)
    (<VERB? TAKE DRINK>
      <TELL
"You sip the water from the pond.  Just what you need to wash down a bit of
grazing." CR>)
    (<VERB? USE-ON PUT-IN>
      <COND
        (<PRSO? ,SOMETHING-ITEM>
          <CALL GET-DUCK-TURD-R>
        )>)>>

<ROUTINE GET-DUCK-TURD-R ()
  <TELL
"You throw the something into the pond.  The ducks swarm around it in curiosity. 
You take the opportunity to grab a duck turd without being noticed!" CR>
  <REMOVE ,SOMETHING-ITEM>
  <MOVE ,DUCK-TURD, PLAYER>>
  
<OBJECT DUCKS
  (DESC "ducks")
  (LDESC "About what you'd expect.")
  (SYNONYM DUCK DUCKS DUCKIE DUCKIES)
  (ADJECTIVE LITTLE TINY)
  (IN ZEKES-FARM)
  (FLAGS NDESCBIT NPREFIXBIT PLURALBIT)>

; ************************* ZEKE'S FARMHOUSE ***********************************

<OBJECT ZEKES-FARMHOUSE
  (IN ROOMS)
  (DESC "Zeke's Farmhouse")
  (FLAGS LIGHTBIT)
  (OUT TO ZEKES-FARM)
  (ACTION ZEKES-FARMHOUSE-R)>

<ROUTINE ZEKES-FARMHOUSE-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"You're inside Farmer Zeke's rather cramped home.  No one's here at the
moment.  Perhaps you should go away.||">)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "out">
      <TELL "." CR>)>>

<OBJECT TABLE
  (IN ZEKES-FARMHOUSE)
  (DESC "table")
  (SYNONYM TABLE)
  (FLAGS CONTBIT SURFACEBIT)
  (ACTION TABLE-R)>

<ROUTINE TABLE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"Hmmm, what's a table doing here?  Cool!  It has a ">
      <BOLDIZE "treasure chest">
      <TELL " on it!" CR>
      <THIS-IS-IT ,TREASURE-CHEST>)
    (<VERB? TAKE>
      <TELL
"Farmer Zeke took the wise precaution of bolting his table to the floor." CR>)>>

<OBJECT TREASURE-CHEST
  (DESC "treasure chest")
  (LDESC "About what you'd expect.")
  (SYNONYM CHEST)
  (ADJECTIVE TREASU TREASURE)
  (IN ZEKES-FARMHOUSE)
  (FLAGS NDESCBIT CONTBIT OPENABLEBIT)
  (ACTION TREASURE-CHEST-R)>

<ROUTINE TREASURE-CHEST-R ()
  <COND
    (<VERB? OPEN>
      <CALL GET-NOTHING-R>)
    (<VERB? TAKE>
      <TELL
"It's too big.  You could open it instead..." CR>)>>

<ROUTINE GET-NOTHING-R ()
  <TELL
"Ooooo!  There's nothing inside!  Told ya you should have gone away." CR>
  <MOVE ,NOTHING-ITEM ,PLAYER>
  <THIS-IS-IT ,NOTHING-ITEM>
  <REMOVE ,TABLE>
  <REMOVE ,TREASURE-CHEST>>


; ************************** ZEKE'S SILO ***************************************

<OBJECT ZEKES-SILO
  (IN ROOMS)
  (SYNONYM SILO)
  (ADJECTIVE ZEKE'S ZEKES)
  (DESC "Zeke's Silo")
  (FLAGS LIGHTBIT)
  (OUT TO ZEKES-FARM)
  (ACTION ZEKES-SILO-R)>

<ROUTINE ZEKES-SILO-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL "Gee, this place smells just like rotting feed.  ">)
    (<==? .RARG ,M-FLASH>
      <TELL 
"Standing in the silo, grinning like the idiot that he is, is Farmer ">
      <BOLDIZE "Zeke">
      <TELL "." CR CR>
      <TELL "You can go ">
      <BOLDIZE "out">
      <TELL "." CR>)>>

<OBJECT ZEKE
  (DESC "Zeke")
  (IN ZEKES-SILO)
  (SYNONYM FARMER ZEKE)
  (ADJECTIVE FARMER)
  (FLAGS PERSONBIT NARTICLEBIT NDESCBIT)
  (ACTION ZEKE-R)>

<ROUTINE ZEKE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "He's wearing a straw hat and at least one of his teeth is rotting
away, but he seems pleased as punch that you've arrived." CR>
    )
    (<VERB? SPEAK>
      <TELL "\"Hey there, good buddy!  Say, bein' a wizard an' all, couldja find
it in yer heart to gimme some magic milk?  I'm all out!\"" CR>)
    (<VERB? GIVE>
      <COND
        (<PRSO? ,MILK>
          <TELL "\"Well, thanks a lot, good buddy!  Well, tell ya what, why
don't I give ya this here pitchfork ta comp'n'sate ya fer yer milk.\"" CR>
          <REMOVE ,MILK>
          <MOVE ,PITCHFORK ,PLAYER>)>)
    (<VERB? ATTACK>
      <TELL "You may be an evil sorcerer, but at least you're an ETHICAL evil
sorcerer.  No killing allowed!  Especially not of idiots.  They don't know
they're idiots." CR>)
    (<VERB? SPLASH>
      <CALL DUMB-LOSE-R>)>>

<ROUTINE DUMB-LOSE-R ()
  <TELL "\"Well, gee,\" says Farmer Zeke, \"I shore do like ya a lot, but I
guess there's a limit!\"" CR>
	<TELL "So saying, Zeke stabs you with his pitchfork." CR>
  <CRLF>
	<JIGS-UP ,LOSE-TEXT>
  <CRLF>
  <V-QUIT>>

; ************************** GOBLIN TRAIL **************************************

<OBJECT GOBLIN-TRAIL
  (IN ROOMS)
  (DESC "Goblin Trail")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH TO ZEKES-FARM)
  (SOUTH TO GOBLIN-LAIR)
  (ACTION GOBLIN-TRAIL-R)>

<ROUTINE GOBLIN-TRAIL-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
        <TELL
"The stench of goblins permeates this place.  Goblins are small, annoying
creatures who like to fight anyone who looks weak.  Fortunately, you don't look
weak." CR CR>
    )
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "north">
      <TELL " or ">
      <BOLDIZE "south">
      <TELL "." CR>)>>

<OBJECT ROAD-GOBLIN-TRAIL
  (DESC "the road")
  (SYNONYM ROAD)
  (IN GOBLIN-TRAIL)
  (FLAGS NARTICLEBIT)
  (ACTION ROAD-GOBLIN-TRAIL-R)>

<ROUTINE ROAD-GOBLIN-TRAIL-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL
"It's made of dirt.  Concrete hasn't been invented yet." CR>)
    (<VERB? TAKE>
      <TELL
"But you're already taking the road!  You're taking it either north or south! 
Har har har!  Hey, I saw a car transform the other day!  Yeah, it turned into a
driveway!" CR>)>>

; ************************** GOBLIN LAIR ***************************************

<OBJECT GOBLIN-LAIR
  (IN ROOMS)
  (DESC "Goblin Lair")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH TO GOBLIN-TRAIL)
  (IN TO INSIDE-GOBLIN-LAIR)
  (ACTION GOBLIN-LAIR-R)>

<ROUTINE GOBLIN-LAIR-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
        <TELL
"About twenty goblins patrol the front of a massive cave complex.  They eye you
for a moment, then decide not to attack.  You return the favor and don't kill
them." CR CR>
    )
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "north">
      <TELL " or ">
      <BOLDIZE "in">
      <TELL "." CR>)>>

<OBJECT CLIFF
  (DESC "cliff")
  (SYNONYM CLIFF)
  (IN GOBLIN-TRAIL)
  (ACTION CLIFF-R)>

<ROUTINE CLIFF-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"It's a cliff; you could climb it, but it might be a difficult climb." CR>)
    (<VERB? TAKE>
      <TELL
"If you want to climb the cliff, say so!" CR>)
    (<VERB? CLIMB>
      <TELL
"After a difficult climb, you reach the top.  You're very pleased with yourself.
 Unfortunately, the ledge crumbles beneath you and you plummet back to the
 ground." CR>)>>

<OBJECT INSIDE-GOBLIN-LAIR-ENTRANCE
  (IN GOBLIN-LAIR)
  (ACTION INSIDE-GOBLIN-LAIR-ENTRANCE-R)
  (DESC "inside the goblin lair")
  (SYNONYM LAIR CAVE)
  (ADJECTIVE INSIDE GOBLIN)
  (FLAGS DOORBIT NDESCBIT)>

<ROUTINE INSIDE-GOBLIN-LAIR-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO INSIDE-GOBLIN-LAIR>
    )>>

<OBJECT GOBLIN-GUARD
  (IN GOBLIN-LAIR)
  (DESC "goblin guard")
  (SYNONYM GOBLIN GUARD)
  (ADJECTIVE GOBLIN)
  (FLAGS PERSONBIT)
  (ACTION GOBLIN-GUARD-R)>

<ROUTINE GOBLIN-GUARD-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"It's very ugly, like most of its kind.  Don't get too close; you could faint
from the smell." CR>)
    (<VERB? SPEAK>
      <TELL
"\"Yu wan go cave?  No try no funny bizniss -- I can tell.\"" CR>
    )>>

<ROUTINE SECRET-ONE-R ()
  <TELL
"\"Ooooo!  Nuthing!  Jus wut I all ways want'd!  Inn ex chaynge, I giv yu summ
thing!\"" CR>
  <REMOVE NOTHING-ITEM>
  <MOVE ,SOMETHING-ITEM ,PLAYER>>

; ************************** INSIDE THE GOBLIN LAIR ****************************

<OBJECT INSIDE-GOBLIN-LAIR
  (IN ROOMS)
  (DESC "Inside the Goblin Lair")
  (ACTION INSIDE-GOBLIN-LAIR-R)
  (FLAGS LIGHTBIT NDESCBIT)
  (OUT TO GOBLIN-LAIR)>

<ROUTINE INSIDE-GOBLIN-LAIR-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"You are escorted to the Goblin King's throne room, a large chamber ornamented
with ">
      <BOLDIZE "statues">
      <TELL " of nude female goblins.  You try hard to avoid puking." CR CR>)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "out">
      <TELL "." CR>)>>

<OBJECT STATUES
  (DESC "statues")
  (SYNONYM STATUE STATUES)
  (IN INSIDE-GOBLIN-LAIR)
  (FLAGS NDESCBIT)
  (ACTION STATUES-R)>

<ROUTINE STATUES-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"Apparently, the goblin idea of beauty is the same as the bovine idea of
putridity.  You'd prefer not to look at these statues." CR>)
    (<VERB? TAKE>
      <TELL
"That would be difficult, considering the statues are about seven feet tall,
are made of stone, weigh about a ton, and are guarded by some mean-looking
goblins." CR>)>>

<OBJECT GOBLIN-KING
  (DESC "the Goblin King")
  (SYNONYM GOBLIN KING)
  (ADJECTIVE GOBLIN)
  (IN INSIDE-GOBLIN-LAIR)
  (FLAGS PERSONBIT NARTICLEBIT)
  (ACTION GOBLIN-KING-R)>

<ROUTINE GOBLIN-KING-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"An officious-looking, double-chinned goblin monarch sits royally atop a throne
of deer hide." CR>)
    (<VERB? SPEAK>
      <TELL
"\"Hoo hoo hoo!  Goblinz so grate, our spit is assid!  We spit on yu if yu make
us angree!  If yu hav tiny statyoo of jade, we giv yu nice thing!\"" CR>
    )>>

<ROUTINE GIFT-OF-KING-R ()
  <REMOVE ,JADE-STATUETTE>
  <MOVE ,GOBLIN-SPIT ,PLAYER>
  <TELL
"\"Ooooo!  You find goblinn lost statyoo!  We giv yu wun jar of spit!\"" CR>>

<ROUTINE OTHER-GIFT-R ()
  <REMOVE ,DUCK-TURD>
  <MOVE ,GRAPPLING-HOOK ,PLAYER>
  <TELL
"\"Ooooo!  GIMME GIMME GIMME!  Duck turd favorite goblin food!  We giv yu
grapple hook!\"" CR>>

; ************************** LAND OF THE NECROYAKS *****************************

<OBJECT LAND-OF-NECROYAKS
  (IN ROOMS)
  (DESC "Land of the Necroyaks")
  (LDESC 
"The greenness of the farmland dissolves into gray bleakness as you pass into
the land of the NecroYaks.  Yaks are the sworn enemies of cows -- you'd better
stay on your toes!|")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (SOUTH TO ZEKES-FARM)
  (NORTH TO AMBUSH-POINT)
  (ACTION LAND-OF-NECROYAKS-R)>

<ROUTINE LAND-OF-NECROYAKS-R (RARG)
  <COND
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "north">
      <TELL " or ">
      <BOLDIZE "south">
      <TELL "." CR>)>>

<OBJECT NECROYAKS-SIGN
  (IN LAND-OF-NECROYAKS)
  (DESC "sign")
  (SYNONYM SIGN)
  (FLAGS TRYTAKEBIT)
  (ACTION NECROYAKS-SIGN-R)>

<ROUTINE NECROYAKS-SIGN-R ()
  <COND
    (<VERB? EXAMINE READ>
      <TELL 
"It reads: ">
      <ITALICIZE 
"\"Unless you own a vial of acid that you can give to the NecroYaks for their
sinister experiments, do not proceed on pain of Death!\"">
      <CRLF>)
    (<VERB? TAKE>
      <TELL 
"Oh, THAT'S original." CR>
    )>>

; ************************** AMBUSH POINT **************************************

<OBJECT AMBUSH-POINT
  (IN ROOMS)
  (DESC "Deep in NecroYak Territory")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (ACTION AMBUSH-POINT-R)
  (SOUTH TO LAND-OF-NECROYAKS)>

<ROUTINE AMBUSH-POINT-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"A cliff face blocks your way here.  It's steep -- you can't climb.  If you want
to continue, you'll have to ">
      <BOLDIZE "search">
      <TELL " the face." CR CR>
    )
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "south">
      <TELL "." CR>
    )>>

<ROUTINE YAKS-KILL-R ()
  <TELL 
"The NecroYaks recognize you as a cow, then jump out and kill you." CR CR>
  <JIGS-UP ,LOSE-TEXT>>

<ROUTINE YAKS-LOVE-R ()
  <TELL 
"The NecroYaks jump out and search you for acid.  They find your goblin spit,
take it, and run off.  But one of them drops a phoenix feather, and you scoop it
up unnoticed.  By the way, there's no way to go farther this way unless you're a
yak." CR>
  <REMOVE ,GOBLIN-SPIT>
  <MOVE ,WING-FEATHER ,PLAYER>>

<SYNTAX SEARCH = V-SEARCH-THE-ROOM>

<ROUTINE V-SEARCH-THE-ROOM ()
  <COND
    (<==? <LOC ,PLAYER> ,AMBUSH-POINT>
      <COND
        (<HELD? ,GOBLIN-SPIT>
          <YAKS-LOVE-R>)
        (T
          <YAKS-KILL-R>)>)
    (T
      <V-SEARCH>)>>

; ************************** PHOENIX MOUNTAIN PASS *****************************

<OBJECT PHOENIX-MOUNTAIN-PASS
  (IN ROOMS)
  (DESC "Phoenix Mountain Pass")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (ACTION PHOENIX-MOUNTAIN-PASS-R)
  (WEST TO ZEKES-FARM)
  (EAST TO PHOENIX-PEAK)>

<ROUTINE PHOENIX-MOUNTAIN-PASS-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"The towering mountains surround you on all sides but back to your west. 
Passage farther east is remotely possible, should you be brave or foolhardy
enough to try it." CR CR>)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <BOLDIZE "west">
      <TELL " or ">
      <BOLDIZE "east">
      <TELL "." CR>)>>

<OBJECT MOUNTAINS
  (DESC "mountains")
  (IN PHOENIX-MOUNTAIN-PASS)
  (FLAGS PLURALBIT NDESCBIT)
  (SYNONYM MOUNTA MOUNTAINS MOUNTAIN)
  (ACTION MOUNTAINS-R)
>

<ROUTINE MOUNTAINS-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"They tower up almost as high as the Great Auk Mountains far, far to the
north." CR>)
    (<VERB? TAKE>
      <TELL 
"After several hours of effort, you manage to chip a piece off of the mountain
you're standing on.  But you accidentally let go and it plummets into the valley
below." CR>)
    (<VERB? CLIMB>
      <CLIMB-THEM-R>)>>

<ROUTINE CLIMB-THEM-R ()
  <COND
    (<HELD? ,GRAPPLING-HOOK>
      <REMOVE ,GRAPPLING-HOOK>
      <MOVE ,PURPLE-PAINT ,PLAYER>
      <TELL 
"On top of the mountain, you find a bunch of purple paint, which you take. 
After descending again, you ditch your grappling hook." CR>)
    (T
      <TELL 
"Those particular mountains are too steep." CR>)>>

; ************************** PHOENIX PEAK **************************************

<OBJECT PHOENIX-PEAK
  (IN ROOMS)
  (DESC "Pheonix Peak")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (ACTION PHOENIX-PEAK-R)
  (WEST TO PHOENIX-MOUNTAIN-PASS)>

<ROUTINE PHOENIX-PEAK-R (RARG)
  <COND
    (<==? .RARG ,M-FLASH>
      <TELL
"After hard hours of climbing, you finally reach the summit of Phoenix Peak. 
Here, in all its glory, sits the ">
      <BOLDIZE "Resplendent Magnificent Phoenix">
      <TELL "." CR CR>
      <TELL "You can go ">
      <BOLDIZE "west">
      <TELL "." CR>)>>

<OBJECT PHOENIX
  (DESC "the Resplendent Magnificent Phoenix")
  (SYNONYM PHOENIX)
  (ADJECTIVE RESPLE REPLENDENT MAGNIF MAGNIFICENT)
  (IN PHOENIX-PEAK)
  (FLAGS PERSONBIT NDESCBIT NARTICLEBIT)
  (ACTION PHOENIX-R)>

<ROUTINE PHOENIX-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"The Resplendent Magnificent Phoenix's visage is so brilliant that it hurts to
look at it." CR>)
    (<VERB? SPEAK>
      <TELL
"The Resplendent Magnificent Phoenix ">
      <COND
        (<HELD? ,FLY-SCROLL>
          <TELL "does not reply." CR>)
        (T
          <TELL "demands to know ">
          <ITALICIZE "why">
          <TELL
" such a weakling as you has come here!  \"If you do not have my wing feather
with you, I'm afraid I must ask you to leave ">
          <ITALICIZE "immediately!">
          <TELL 
"  Now, do you have my wing feather or not?\" -- ">
          <BOLDIZE "Yes">
          <TELL " or ">
          <BOLDIZE "No">
          <TELL "?" CR CR>
          <COND
            (<YES?>
              <PHOENIX-PROC-R>)
            (T
              <PHOENIX-KILL-R>)>)>)>>

<ROUTINE PHOENIX-PROC-R ()
  <TELL 
"Thank you; you have found my wing feather.  In the wrong hands, that could have
been very dangerous.  I will give you this \"fly\" scroll to compensate you for
your hard work.  ">
  <BOLDIZE "Use">
  <TELL " the scroll to fly, but it will only work once." CR>
  <MOVE ,FLY-SCROLL ,PLAYER>
  <REMOVE ,WING-FEATHER>>

<ROUTINE PHOENIX-KILL-R ()
  <TELL 
"\"Then give it to me quickly!  What..... You don't have my wing feather at all,
do you?  You shammer.  I was going to dismiss you without hurting you, but I'm
afraid now I'll have to kill you.\"||The Resplendent Magnificent Phoenix bats
you with one claw.  You roll back down the mountainside, finally coming to a
complete stop looking very much like a well-done steak." CR CR>
  <JIGS-UP ,LOSE-TEXT>>

; ************************** END OF ROOM DESCRIPTIONS **************************

<GLOBAL WIN-TEXT "Congratulations, you have found out that you were better off
where you started anyway.  The grass here is brown and crackly.  Too bad!
 And... OH NO!  Now you're trapped here, alone with the NecroYaks!  Stay tuned
for \"The Adventures of Koww the Magician II -- Escape from the NecroYaks!\"">

<GLOBAL LOSE-TEXT "Idiot.  You die.  HA HA HA HA HA!">

<ROUTINE FINISH-R ()
  <COND
    (<HELD? FLY-SCROLL>
      <CALL END-R>)
    (T
      <TELL "Maybe you'll find it someday, but you don't have it today.  You
stupid cow." CR>)>>

<ROUTINE END-R ()
  <TELL "You fly up and over the chasm!" CR CR>
  <TELL ,WIN-TEXT CR CR>
  <QUIT>>

; *** TEXT ROUTINES ***

<ROUTINE BOLDIZE (TEXT)
  <HLIGHT 2>
  <TELL .TEXT>
  <HLIGHT 0>>