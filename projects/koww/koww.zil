"KOWW main file"

<VERSION XZIP>
<CONSTANT RELEASEID 0>

<CONSTANT GAME-BANNER
"The Adventures of Koww the Magician
|Based upon the original Quest 2 game by Brian the Great
|Copyright (c) 1999-2025 Brian the Great
|v0.2.5 beta
|IFID: BC868ACA-5C70-4EBD-8E87-7DC9C3C3E5F1">

<ROUTINE GO ()
  <SETG MODE ,VERBOSE>
  <SETG SHOW-LINKS T>
  <CRLF>
  <CRLF>
  <ITALICIZE 
"***  Find out if the grass is really greener on the other side of the chasm.  ***">
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <HLIGHT ,H-ITALIC>
  <TELL "[YOU CAN ENTER 'HINTS' TO ACCESS THE INVISICLUES HINTS MENU]">
  <HLIGHT ,H-NORMAL>
  <CRLF>
  <CRLF>
  <CRLF>
  <ADD-JS-SCRIPT "zilJs._room = 'KOWWS-CHASM';">
  <ADD-JS-SCRIPT "$('body').css('background-color','slategray');">
  <SETG HERE ,KOWWS-CHASM>
  <MOVE ,PLAYER ,HERE>
  <UPDATE-EXITS-JS>
  <V-LOOK>
  <SETG SCORING-ENABLED T>
  <MAIN-LOOP>
>


;"----------------------- UNCOMMENT TO ENABLE DEBUGGING COMMANDS ----------------------------------"
;<COMPILATION-FLAG DEBUGGING-VERBS T>
;<COMPILATION-FLAG DEBUG T>

<SETG EXTRA-FLAGS (USEBIT GIVEBIT)>

<INSERT-FILE "parser">

<SET REDEFINE T>

<INSERT-FILE "kowwverbs">
<INSERT-FILE "kowwified">
<INSERT-FILE "hints">
<INSERT-FILE "koww-links">

<CONSTANT MAX-SCORE 420>

<ROUTINE INCREMENT-SCORE (NUM)
  <SETG SCORE <+ ,SCORE .NUM>>
  <TELL 
"[Your score has just increased by " N .NUM ".]" CR CR>
>

;" ************************* ITEMS **********************************************"

<ROUTINE QUEST-TWO-R ()
  <COND
    (<==? ,PRSA ,V?EXAMINE>
      <TELL 
"About what you'd expect from " T, PRSO "." CR>)
    (<==? ,PRSA ,V?DROP>
      <TELL "Dropping " T, PRSO " would be anti-productive." CR>)
    (<OR <==? ,PRSA ,V?PUT-IN><==? ,PRSA ,V?PUT-ON>>
      <TELL "That would be anti-productive." CR>)>>

<OBJECT MILK
  (IN PLAYER)
  (DESC "your milk")
  (SDESC "your milk")
  (SYNONYM MILK)
  (ADJECTIVE MY MAGICAL MAGIC)
  (ACTION MILK-R)
  (FLAGS NARTICLEBIT GIVEBIT)>

<ROUTINE MILK-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"You are more than familiar with your own magical milk." CR>
    )
    (<VERB? DROP PUT-IN PUT-ON>
      <TELL 
"Why would you do that?  Awful waste of milk." CR>
    )
    (<VERB? GIVE>
      <COND
        (<PRSI? ZEKE>
          <INCREMENT-SCORE 40>
          <TELL 
"\"Well, thanks a lot, good buddy!  Well, tell ya what, why don't I give ya this
here pitchfork ta comp'n'sate ya fer yer milk.\"" CR>
          <REMOVE ,MILK>
          <MOVE ,PITCHFORK ,PLAYER>
          <THIS-IS-IT ,PITCHFORK>
          <RTRUE>
        )
      >
    )
    (<VERB? THINK-ABOUT>
      <TELL "Zeke is quite fond of your magic milk, but you can only GIVE so much each day." CR>
    )
  >
>

<OBJECT PITCHFORK
  (DESC "pitchfork")
  (SDESC "pitchfork")
  (SYNONYM PITCHF PITCHFORK)
  (ACTION PITCHFORK-R)
  (FLAGS USEBIT)
>

<ROUTINE PITCHFORK-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "A sharp-looking tool!" CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? USE-ON DIG>
      <COND
        (<OR 
          <AND <VERB? USE-ON><PRSI? ,HAYSTACK>>
          <AND <VERB? DIG><PRSO? ,HAYSTACK>>>
            <OPEN-STATUE-CAVE-R>
            <RTRUE>)>)
    (<AND <VERB? USE><==? ,HERE ,ZEKES-FARM>>
      <SETG PRSA ,V?USE-ON>
      <SETG PRSI ,HAYSTACK>
      <PERFORM ,PRSA ,PRSO ,PRSI>
      <RTRUE>)
    (<VERB? THINK-ABOUT>
      <TELL
"Hmm... You think there's probably something to use the pitchfork on, in much the same way Farmer
Zeke sometimes uses it." CR>)>>

<OBJECT FLY-SCROLL
  (DESC "the Fly Scroll")
  (SDESC "the Fly Scroll")
  (SYNONYM FLY SCROLL SPELL)
  (ADJECTIVE FLY)
  (ACTION FLY-SCROLL-R)
  (FLAGS TAKEBIT NARTICLEBIT SPELLBIT USEBIT)>

<ROUTINE FLY-SCROLL-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "Try using it (when in the proper location)." CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>
    )
    (<VERB? USE CAST>
      <CALL FINISH-R>
      <RTRUE>)
    (<VERB? THINK-ABOUT>
      <TELL "You need to be in the proper location to use it." CR>)>>


<OBJECT WING-FEATHER
  (DESC "wing feather")
  (SDESC "wing feather")
  (SYNONYM WING FEATHER)
  (ADJECTIVE WING PHOENI PHOENIX)
  (FLAGS TAKEBIT GIVEBIT)
  (ACTION WING-FEATHER-R)>

<ROUTINE WING-FEATHER-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "A wing feather from a Phoenix." CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>
    )
    (<VERB? THINK-ABOUT>
      <TELL "You should probably find its original owner." CR>
    )
    (<VERB? USE>
      <TELL "You can't use it. You should probably return it to its owner." CR>
      <RTRUE>
    )>>

<OBJECT JADE-STATUETTE
  (DESC "jade statuette")
  (SDESC "jade statuette")
  (SYNONYM JADE STATUETTE STATUE)
  (ADJECTIVE JADE)
  (FLAGS TAKEBIT GIVEBIT)
  (ACTION JADE-STATUETTE-R)>

<ROUTINE JADE-STATUETTE-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL "The ugly statuette is a waste of jade." CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? GIVE>
      <COND
        (<PRSI? ,GOBLIN-KING>
          <GIFT-OF-KING-R>
          <RTRUE>)>)
    (<VERB? THINK-ABOUT>
      <TELL "It seems like a gift fit for a king!" CR>)>>

<OBJECT GOBLIN-SPIT
  (DESC "goblin spit")
  (SDESC "goblin spit")
  (SYNONYM SPIT)
  (ADJECTIVE GOBLIN)
  (FLAGS TAKEBIT NARTICLEBIT)
  (ACTION GOBLIN-SPIT-R)>

<ROUTINE GOBLIN-SPIT-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL "Yuck... It's chunky!" CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? SMELL>
      <TELL "Yuck!" CR>)
    (<VERB? THINK-ABOUT>
      <TELL 
"After a turn of thinking, you ">
    <COND
      (<FSET? ,LAND-OF-NECROYAKS ,TOUCHBIT>
        <TELL "remember a sign somewhere saying something about acid">
      )
      (T
        <TELL "decide you need to explore a little more to find a place to use it">
      )
    >
    <TELL "." CR>)>>

<OBJECT SOMETHING-ITEM
  (DESC "something")
  (SDESC "something")
  (SYNONYM SOMETHING)
  (FLAGS TAKEBIT NARTICLEBIT USEBIT)
  (ACTION SOMETHING-ITEM-R)>

<ROUTINE SOMETHING-ITEM-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL "About what you'd expect something to look like in this game." CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? USE-ON PUT-IN>
      <COND
        (<PRSI? ,POND>
          <CALL GET-DUCK-TURD-R>
          <RTRUE>)>)
    (<AND <VERB? USE><==? ,HERE ,ZEKES-FARM>>
      <SETG PRSA ,V?USE-ON>
      <SETG PRSI ,POND>
      <PERFORM ,PRSA ,PRSO ,PRSI>
      <RTRUE>)
    (<VERB? THINK-ABOUT>
      <TELL 
"You think about it for a complete turn, and you decide you should simply put
something in the pond!" CR>)>>

<OBJECT NOTHING-ITEM
  (DESC "nothing")
  (SDESC "nothing")
  (SYNONYM NOTHING)
  (FLAGS TAKEBIT NARTICLEBIT GIVEBIT)
  (ACTION NOTHING-ITEM-R)>

<ROUTINE NOTHING-ITEM-R ()
  <COND
    (<VERB? SMELL>
      <TELL "You smell nothing." CR>)
    (<VERB? EXAMINE>
      <TELL "It doesn't look like much of anything!" CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <TELL "Are you serious?" CR>)
    (<VERB? GIVE>
      <COND
        (<PRSI? ,GOBLIN-GUARD>
          <CALL SECRET-ONE-R>
          <RTRUE>)>)
    (<VERB? THINK-ABOUT>
      <TELL 
"Perhaps you can find someone who'll give you something for nothing?" CR>)>>

<OBJECT DUCK-TURD
  (DESC "duck turd")
  (SDESC "duck turd")
  (SYNONYM TURD)
  (ADJECTIVE DUCK)
  (FLAGS TAKEBIT GIVEBIT)
  (ACTION DUCK-TURD-R)>

<ROUTINE DUCK-TURD-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL "About what you'd expect, obviously dropped by something fowl." CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? GIVE>
      <COND
        (<PRSI? ,GOBLIN-KING>
          <OTHER-GIFT-R>
          <RTRUE>)>)
    (<VERB? SMELL>
      <SILLY>)
    (<VERB? THINK-ABOUT>
      <TELL "You decide you should find a disgusting NPC who might want it." CR>)>>

<OBJECT GRAPPLING-HOOK
  (DESC "grappling hook")
  (SDESC "grappling hook")
  (SYNONYM HOOK)
  (ADJECTIVE GRAPPLING)
  (FLAGS TAKEBIT USEBIT)
  (ACTION GRAPPLING-HOOK-R)>

<ROUTINE GRAPPLING-HOOK-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL "It looks strong enough to support a cow!" CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? USE>
      <COND
        (<==? <LOC ,PLAYER> ,MOUNTAINS>
          <CLIMB-THEM-R>
          <RTRUE>)>)
    (<VERB? USE-ON>
      <COND
        (<PRSO? ,MOUNTAINS>
          <CLIMB-THEM-R>
          <RTRUE>)>)
    (<VERB? THINK-ABOUT>
      <TELL 
"It doesn't even take you the full turn to realize that this needs to be used to
climb something." CR>)>>

<OBJECT PURPLE-PAINT
  (DESC "purple paint")
  (SDESC "purple paint")
  (SYNONYM PURPLE PAINT)
  (ADJECTIVE PURPLE)
  (FLAGS TAKEBIT NARTICLEBIT WEARBIT USEBIT)
  (ACTION PURPLE-PAINT-R)>

<ROUTINE PURPLE-PAINT-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL "It's paint, and it's purple." CR>)
    (<VERB? DROP PUT-IN PUT-ON>
      <QUEST-TWO-R>)
    (<VERB? USE>
      <COND
        (<==? <LOC ,PLAYER> ,ZEKES-SILO>
          <PURPLE-USE-R>
          <RTRUE>)>)
    (<VERB? WEAR>
        <PURPLE-USE-R>
        <RTRUE>)
    (<VERB? SMELL>
      <TELL "It smells like... about 15 points!" CR>)
    (<VERB? THINK-ABOUT>
      <TELL 
"You probably need to be in the right place before you try to use it." CR>)>>

<ROUTINE PURPLE-USE-R ()
  <COND
    (<HELD? ,PURPLE-PAINT>
      <COND
        (<==? <LOC ,PLAYER> ,ZEKES-SILO>
          <PURPLE-COW-R>)
        (T
          <TSD>)>)
    (T
      <TELL
"You don't know where that is." CR>)>>

<GLOBAL PAINTED <>>

<ROUTINE PURPLE-COW-R ()
  <INCREMENT-SCORE 1>
  <REMOVE ,PURPLE-PAINT>
  <SETG PAINTED T>
  <TELL
"You spread the purple paint on yourself.  Suddenly Farmer Zeke bursts into
song!" CR CR>
  <TELL "\"">
  <ITALICIZE 
"I never saw a purple cow, and I never hope to see one; but I can tell you
anyhow, I'd rather see than be one!">
  <TELL "\"" CR CR>
  <TELL
"Wonderful!  You have just activated the scenario's secret feature!  That's it. 
Return to your home.  There's nothing more to do here." CR>
>


;" ************************* KOWW'S CHASM ***************************************"

<OBJECT KOWWS-CHASM
  (PNAME "KOWWS-CHASM")
  (IN ROOMS)
  (DESC "Koww's Chasm")
  (FLAGS LIGHTBIT)
  (ACTION KOWWS-CHASM-R)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (THINGS (PURE GREEN) (PASTURE GRASS) "It's very, very green.")
  (EAST TO ZEKES-FARM)>

<ROUTINE KOWWS-CHASM-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL 
"You are outside in a pasture of pure, pure green.  Green as far as the eye can
see.  But you, Koww the Magician, are not satisfied.  The grass may be even
greener on the other side of the ">
      <OBJECT-LINK "chasm">
      <TELL "... you must know!  Also in the area is a very undramatic ">
      <OBJECT-LINK "sign">
      <TELL "." CR CR>)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <EXIT-LINK "east">
      <TELL "." CR>)>>

<OBJECT CHASM-SIGN
  (DESC "sign")
  (SYNONYM SIGN)
  (ADJECTIVE VERY UNDRAMATIC)
  (IN KOWWS-CHASM)
  (FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
  (ACTION CHASM-SIGN-R)>

<OBJECT CHASM
  (DESC "chasm")
  (FLAGS NDESCBIT TAKEBIT)
  (SYNONYM CHASM)
  (IN KOWWS-CHASM)
  (ACTION CHASM-R)>


<ROUTINE CHASM-SIGN-R ()
    <COND
      (<VERB? EXAMINE READ>
        <TELL "It reads: '">
        <ITALICIZE "Got milk?  Come to Farmer Zeke's mag-NIFicent silo!">
        <TELL "'" CR>)
      (<VERB? TAKE>
        <TELL 
"You yank the sign out of the ground and try to fit it in your Koww-pack.  But
it just doesn't fit.  Frustrated, you put it back." CR>
        <FCLEAR ,KOWW-PACK ,INVISIBLE>)>>

<ROUTINE CHASM-R ()
  <COND
    (<VERB? TAKE>
      <TELL 
"Don't worry, the men in the white coats will soon be here to deal with you.|">)
    (<VERB? EXAMINE>
      <TELL 
"That's the chasm you simply MUST cross!  Surely the only way to cross it is to
FLY!" CR>)
    (<VERB? SEARCH>
      <TELL "That is not possible from your current location." CR>
    )>>

;" ************************* ZEKE'S FARM ****************************************"

<OBJECT ZEKES-FARM
  (PNAME "ZEKES-FARM")
  (IN ROOMS)
  (DESC "Zeke's Farm")
  (ACTION ZEKES-FARM-R)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (WEST TO KOWWS-CHASM)
  (SOUTH TO GOBLIN-TRAIL)
  (EAST TO PHOENIX-MOUNTAIN-PASS)
  (NORTH TO LAND-OF-NECROYAKS)
  (IN PER IN-FROM-FARM-R)
  (GLOBAL GOBLINS-SMELL FARMER-SMELL)>

<ROUTINE ZEKES-FARM-R (RARG)
  <COND
    (<==? .RARG ,M-FLASH>
      <TELL "You stand outside of a small ">
      <BOLDIZE "farmhouse">
      <TELL " with a ">
      <BOLDIZE "silo">
      <TELL " beside it.  There is a ">
      <OBJECT-LINK "haystack">
      <TELL " and a ">
      <OBJECT-LINK "pond">
      <TELL " here." CR CR>
      <TELL "You can go ">
      <EXIT-LINK "west">
      <TELL ", ">
      <EXIT-LINK "south">
      <TELL ", ">
      <EXIT-LINK "east">
      <TELL ", or ">
      <EXIT-LINK "north">
      <TELL "." CR>
      <CRLF>
      <TELL
"You can go to ">
      <EXIT-LINK "go to Zeke\\\'s Farmhouse" "Zeke\'s Farmhouse">
      <TELL ", or ">
      <EXIT-LINK "go to Zeke\\\'s Silo" "Zeke\'s Silo">
      <TELL "." CR>
    )
    (<AND <==? .RARG ,M-BEG><VERB? SWIM>>
      <TELL "The pond is not deep enough. Besides, you'd scare the ducks." CR>
    )
    (<AND <==? .RARG ,M-BEG><VERB? MOO>>
      <TELL "You moo. The little ducks quack." CR>
    )
  >
>

<ROUTINE IN-FROM-FARM-R ("AUX" RESULT WORD-POS)
  <TELL "Which do you want to enter, the farmhouse or the silo?||>">
  <READLINE>
  <SET WORD-POS 1>
  <SET RESULT <GET ,LEXBUF .WORD-POS>>
  <COND
    (<OR <==? .RESULT ,W?THE><==? .RESULT ,W?ZEKE\'S><==? .RESULT ,W?ZEKES>>
      <SET WORD-POS <+ .WORD-POS 2>>
      <SET RESULT <GET ,LEXBUF .WORD-POS>>
    )
  >
  <COND
    (<EQUAL? .RESULT ,W?FARMHOUSE ,W?HOUSE ,W?FARM>
      <GOTO ,ZEKES-FARMHOUSE>
      <RETURN 0>
    )
    (<EQUAL? .RESULT ,W?SILO>
      <GOTO ,ZEKES-SILO>
      <RETURN 0>
    )
    (T
      <PARSER>
    )
  >
>

<OBJECT ZEKES-FARMHOUSE-ENTRANCE
  (IN ZEKES-FARM)
  (SYNONYM FARMHO FARMHOUSE FARM HOUSE)
  (ADJECTIVE ZEKE\'S ZEKES)
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
  (ADJECTIVE ZEKE\'S ZEKES)
  (DESC "Zeke's Silo")
  (FLAGS NARTICLEBIT NDESCBIT DOORBIT)
  (ACTION ZEKES-SILO-ENTRANCE-R)>

<ROUTINE ZEKES-SILO-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO ZEKES-SILO>
    )>>


<ROUTINE ZEKES-SILO-ENTRANCE-R ()
  <COND
    (<AND <VERB? ENTER>
          <NOT ,PRSO-DIR>>  ;"Only GOTO if not coming from V-ENTER"
      <GOTO ZEKES-SILO>
    )>>

<OBJECT HAYSTACK
  (DESC "haystack")
  (SYNONYM HAY HAYSTA HAYSTACK)
  (IN ZEKES-FARM)
  (FLAGS NDESCBIT TAKEBIT TRYTAKEBIT EDIBLEBIT ATTACKBIT)
  (ACTION HAYSTACK-R)>

<ROUTINE HAYSTACK-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"About what you'd expect from a haystack">
      <COND
        (<==? <LOC ,HOLE> ,HERE>
          <TELL ", except it's in a hole." CR>)
        (T
          <TELL ".  It's made of... HAY!  You munch on it
for a while." CR>)>)
    (<VERB? EAT TAKE>
      <TELL 
"You take a bite of the haystack.  Yummy... tastes just like chicken!" CR>)
    (<VERB? DRINK>
      <TELL
"What, drink THAT?!?!?  You loony." CR>)
    (<VERB? STAB ATTACK SEARCH LOOK-UNDER>
      <OPEN-STATUE-CAVE-R>
      <RTRUE>)
    (<AND <VERB? DIG><PRSI? ,PITCHFORK>>
      <OPEN-STATUE-CAVE-R>
      <RTRUE>
    )
    (<VERB? THINK-ABOUT>
      <COND
        (<FSET? ,JADE-STATUETTE ,TOUCHBIT>
          <TELL "It has no more purpose in this game." CR>
        )
        (<HELD? ,PITCHFORK>
          <TELL 
"Hmmm... You think you probably have the proper tool to use on it...." CR>
        )
        (T
          <TELL 
"It seems important. Maybe you just need something else first." CR>
        )
      >
    )>>

<ROUTINE OPEN-STATUE-CAVE-R ()
  <COND
    (<HELD? ,PITCHFORK>
      <INCREMENT-SCORE 40>
      <TELL
"You stab the pitchfork into the haystack.  Lo and behold, the pitchfork breaks,
and the haystack falls down into a hole in the ground!  Inside the hole is a
jade statuette, which you take." CR>
      <REMOVE ,PITCHFORK>
      <MOVE ,HOLE ,HERE>
      <MOVE ,JADE-STATUETTE ,PLAYER>
      <FSET ,JADE-STATUETTE ,TOUCHBIT>
      <THIS-IS-IT ,JADE-STATUETTE>
    )
    (<FSET? ,JADE-STATUETTE ,TOUCHBIT>
      <TELL
"You've already done that bit." CR>)
    (T
      <TELL
"You don't have the required tool." CR>)>>

<OBJECT HOLE
  (DESC "hole")
  (LDESC "About what you'd expect from a hole.")
  (SYNONYM HOLE)
  (FLAGS NDESCBIT)>

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
    (<VERB? EAT>
      <TELL
"That doesn't look appetizing.  You chew your cud instead." CR>)
    (<VERB? USE-ON PUT-IN>
      <COND
        (<PRSO? ,SOMETHING-ITEM>
          <CALL GET-DUCK-TURD-R>
        )>)
    (<VERB? SMELL>
      <TELL "It smells like pond water and duck turds." CR>)
    (<VERB? THINK-ABOUT>
      <TELL 
"You've always gotten a kick out of putting something into ponds like this..." CR>)
    (<VERB? OPEN CLOSE>
      <TELL "Funny." CR>
    )>>


<ROUTINE GET-DUCK-TURD-R ()
  <INCREMENT-SCORE 40>
  <TELL
"You throw the something into the pond.  The ducks swarm around it in curiosity. 
You take the opportunity to grab a duck turd without being noticed!" CR>
  <REMOVE ,SOMETHING-ITEM>
  <MOVE ,DUCK-TURD, PLAYER>
  <THIS-IS-IT ,DUCK-TURD>
>

<OBJECT DUCKS
  (DESC "ducks")
  (LDESC "About what you'd expect ducks to look like.")
  (SYNONYM DUCK DUCKS DUCKIE DUCKIES)
  (ADJECTIVE LITTLE TINY)
  (IN ZEKES-FARM)
  (FLAGS NDESCBIT NPREFIXBIT PLURALBIT)
  (ACTION DUCKS-R)>

<ROUTINE DUCKS-R ()
  <COND
    (<VERB? SPEAK>
      <TELL "They quack back at you." CR>
    )
  >
>

;" ************************* ZEKE'S FARMHOUSE ***********************************"

<OBJECT ZEKES-FARMHOUSE
  (PNAME "ZEKES-FARMHOUSE")
  (IN ROOMS)
  (DESC "Zeke's Farmhouse")
  (FLAGS LIGHTBIT)
  (OUT TO ZEKES-FARM)
  (ACTION ZEKES-FARMHOUSE-R)
  (GLOBAL FARMER-SMELL)>

<ROUTINE ZEKES-FARMHOUSE-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"You're inside Farmer Zeke's rather cramped home.  No one's here at the
moment.  Perhaps you should go away.||There is a ">
    <OBJECT-LINK "table">
    <COND
      (<NOT <FSET? ,TREASURE-CHEST ,NDESCBIT>>
        <TELL " (on which there is a ">
        <OBJECT-LINK "treasure chest">
        <TELL ")">
      )
    >
    <TELL " here.||">)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <EXIT-LINK "out">
      <TELL "." CR>)>>

<OBJECT TABLE
  (IN ZEKES-FARMHOUSE)
  (DESC "the table")
  (SYNONYM TABLE)
  (FLAGS CONTBIT SURFACEBIT NDESCBIT NARTICLEBIT TAKEBIT TRYTAKEBIT)
  (ACTION TABLE-R)>


<ROUTINE TABLE-R ()
  <COND
    (<VERB? TAKE>
      <TELL
"Farmer Zeke took the wise precaution of bolting his table to the floor.">
      <AND <FSET? ,TREASURE-CHEST ,NDESCBIT>
        <TELL " Cool!  It has a ">
        <OBJECT-LINK "treasure chest" "TREASURE CHEST">
        <TELL " on it!">
        <FCLEAR ,TREASURE-CHEST ,NDESCBIT>
      >
      <CRLF>
    )
    (<VERB? EXAMINE>
      <TELL "Hmmm, what's a table doing here?">
      <AND <FSET? ,TREASURE-CHEST ,NDESCBIT>
        <TELL " Cool!  It has a ">
        <OBJECT-LINK "treasure chest" "TREASURE CHEST">
        <TELL " on it!">
        <FCLEAR ,TREASURE-CHEST ,NDESCBIT>
      >
      <CRLF>
    )
  >
>

<OBJECT TREASURE-CHEST
  (DESC "treasure chest")
  (LDESC "Exactly how you'd expect a treasure chest would look.|")
  (SYNONYM CHEST)
  (ADJECTIVE TREASU TREASURE)
  (IN TABLE)
  (FLAGS NDESCBIT CONTBIT OPENABLEBIT TAKEBIT TRYTAKEBIT)
  (ACTION TREASURE-CHEST-R)>

<ROUTINE TREASURE-CHEST-R ()
  <COND
    (<FSET? ,TREASURE-CHEST ,NDESCBIT>
      <FCLEAR ,TREASURE-CHEST ,NDESCBIT>
    )
  >
  <COND
    (<VERB? OPEN>
      <COND
        (<NOT <FSET? ,NOTHING-ITEM ,TOUCHBIT>>
          <GET-NOTHING-R>
          <ADD-JS-SCRIPT "$('.chest-verbs-list-holder').html(`<span class=\"chest-verbs-list-holder\"><a href=\"#\" onclick=\"sendCmd('examine treasure chest')\">Examine</a><br><a href=\"#\" onclick=\"sendCmd('take treasure chest')\">Take</a><br><a href=\"#\" onclick=\"sendCmd('close treasure chest')\">Close</a><br>`); ">
          <RTRUE>
        )
      >
    )
    (<VERB? CLOSE>
      <COND
        (<FSET? ,TREASURE-CHEST ,OPENBIT>
          <TELL "It appears to be stuck open, but that's okay. We're done with it now." CR>
        )
        (ELSE
          <TELL "It's already closed." CR>
        )
      >
    )
    (<VERB? TAKE>
      <TELL "It's too big.">
      <COND
        (<NOT <FSET? ,TREASURE-CHEST ,OPENBIT>>
          <TELL " You could open it instead...">
        )
      >
      <CRLF>
    )
  >
>

<ROUTINE GET-NOTHING-R ()
  <INCREMENT-SCORE 40>
  <TELL
"Ooooo!  There's nothing inside!  Told ya you should have gone away." CR>
  <MOVE ,NOTHING-ITEM ,PLAYER>
  <FSET ,NOTHING-ITEM ,TOUCHBIT>
  <THIS-IS-IT ,NOTHING-ITEM>
  <FSET ,TREASURE-CHEST ,OPENBIT>
  <RTRUE>
>


;"************************** ZEKE'S SILO ***************************************"

<OBJECT ZEKES-SILO
  (PNAME "ZEKES-SILO")
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
      <TELL "Gee, this place smells just like rotting feed.  ">
    )
    (<==? .RARG ,M-FLASH>
      <TELL 
"Standing in the silo, grinning like the idiot that he is, is Farmer ">
      <NPC-LINK "Zeke">
      <TELL "." CR CR>
      <TELL "You can go ">
      <EXIT-LINK "out">
      <TELL "." CR>
    )
    (<AND <==? .RARG ,M-BEG><VERB? MOO>>
      <TELL "You moo. Zeke tips his hat." CR>
    )
  >
>

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
    (<VERB? ATTACK>
      <TELL "You may be an evil sorcerer, but at least you're an ETHICAL evil
sorcerer.  No killing allowed!  Especially not of idiots.  They don't know
they're idiots." CR>)
    (<VERB? SPLASH>
      <CALL DUMB-LOSE-R>)
    (<VERB? THINK-ABOUT>
      <TELL "He LOVES your magic milk, and purple cows!" CR>)>>

<ROUTINE DUMB-LOSE-R ()
  <TELL "\"Well, gee,\" says Farmer Zeke, \"I shore do like ya a lot, but I
guess there's a limit!\"" CR>
	<TELL "So saying, Zeke stabs you with his pitchfork." CR>
  <CRLF>
	<JIGS-UP ,LOSE-TEXT>
  <CRLF>
  <V-QUIT>>

;"************************** GOBLIN TRAIL **************************************"

<OBJECT GOBLIN-TRAIL
  (PNAME "GOBLIN-TRAIL")
  (IN ROOMS)
  (DESC "Goblin Trail")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH TO ZEKES-FARM)
  (SOUTH TO GOBLIN-LAIR)
  (ACTION GOBLIN-TRAIL-R)
  (DOWN "Down the road?")
  (UP "Try climbing instead.")
  (GLOBAL GOBLINS-SMELL)>

<ROUTINE GOBLIN-TRAIL-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
        <TELL
"The stench of goblins permeates this place.  Goblins are small, annoying
creatures who like to fight anyone who looks weak.  Fortunately, you don't look
weak." CR CR>
    )
    (<==? .RARG ,M-FLASH>
      <TELL "The ">
      <OBJECT-LINK "road">
      <TELL " leads ">
      <EXIT-LINK "north">
      <TELL " or ">
      <EXIT-LINK "south">
      <TELL "." CR>
    )
    (<AND <==? .RARG ,M-BEG><VERB? MOO>>
      <TELL "You moo. The Goblin guard laughs." CR>
    )
  >
>

<OBJECT ROAD
  (DESC "the road")
  (SYNONYM ROAD)
  (IN GOBLIN-TRAIL)
  (FLAGS NARTICLEBIT NDESCBIT TAKEBIT TRYTAKEBIT)
  (ACTION ROAD-R)>

<ROUTINE ROAD-R ()
  <COND
    (<VERB? EXAMINE>
        <TELL
"It's made of dirt.  Concrete hasn't been invented yet." CR>)
    (<VERB? TAKE>
      <TELL
"But you're already taking the road!  You're taking it either north or south! 
Har har har!  Hey, I saw a car transform the other day!  Yeah, it turned into a
driveway!" CR>)>>

;"************************** GOBLIN LAIR ***************************************"

<OBJECT GOBLIN-LAIR
  (PNAME "GOBLIN-LAIR")
  (IN ROOMS)
  (DESC "Goblin Lair")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH TO GOBLIN-TRAIL)
  (IN TO INSIDE-GOBLIN-LAIR)
  (ACTION GOBLIN-LAIR-R)
  (GLOBAL GOBLINS)>

<ROUTINE GOBLIN-LAIR-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
        <TELL
"About twenty goblins patrol the front of a massive cave complex.  They eye you
for a moment, then decide not to attack.  You return the favor and don't kill
them." CR CR>
    )
    (<==? .RARG ,M-FLASH>
      <TELL "A ">
      <NPC-LINK "Goblin guard">
      <TELL " stands nearby.|" CR>
      <TELL "You can go ">
      <EXIT-LINK "north">
      <TELL "." CR CR>
      <TELL "You can ">
      <EXIT-LINK "enter the Cave">
      <TELL "." CR>)>>

<OBJECT INSIDE-GOBLIN-LAIR-ENTRANCE
  (IN GOBLIN-LAIR)
  (ACTION INSIDE-GOBLIN-LAIR-ENTRANCE-R)
  (DESC "cave")
  (SYNONYM LAIR CAVE)
  (ADJECTIVE GOBLIN)
  (FLAGS DOORBIT NDESCBIT)>

<ROUTINE INSIDE-GOBLIN-LAIR-ENTRANCE-R ()
  <COND
    (<VERB? ENTER>
      <GOTO-LAIR>
    )>>

<ROUTINE GOTO-LAIR ()
  <DO-WALK ,P?IN>
>

<OBJECT GOBLIN-GUARD
  (IN GOBLIN-LAIR)
  (DESC "the Goblin Guard")
  (SYNONYM GOBLIN GUARD)
  (ADJECTIVE GOBLIN)
  (FLAGS PERSONBIT NARTICLEBIT NDESCBIT)
  (ACTION GOBLIN-GUARD-R)>

<ROUTINE GOBLIN-GUARD-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"It's very ugly, like most of its kind.  Don't get too close; you could faint
from the smell." CR>)
    (<VERB? SPEAK>
      <TELL
"\"Yu wan go cave?  No try no funny bizniss -- I can tell.\"" CR>)
    (<VERB? SMELL>
      <SILLY>)
    (<VERB? THINK-ABOUT>
      <TELL "He seems to want nothing." CR>)>>

<ROUTINE SECRET-ONE-R ()
  <INCREMENT-SCORE 40>
  <TELL
"\"Ooooo!  Nuthing!  Jus wut I all ways want'd!  Inn ex chaynge, I giv yu summ
thing!\"" CR>
  <REMOVE NOTHING-ITEM>
  <MOVE ,SOMETHING-ITEM ,PLAYER>
  <THIS-IS-IT ,SOMETHING-ITEM>
  <RTRUE>
>
  


;" ************************** INSIDE THE GOBLIN LAIR ****************************"

<OBJECT INSIDE-GOBLIN-LAIR
  (PNAME "INSIDE-GOBLIN-LAIR")
  (IN ROOMS)
  (DESC "Inside the Goblin Lair")
  (LDESC "You can go Inside the Goblin Lair.")
  (ACTION INSIDE-GOBLIN-LAIR-R)
  (FLAGS LIGHTBIT NDESCBIT NARTICLEBIT)
  (OUT TO GOBLIN-LAIR)>

<ROUTINE INSIDE-GOBLIN-LAIR-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"You are escorted to the Goblin King's throne room, a large chamber ornamented
with ">
      <OBJECT-LINK "statues">
      <TELL " of nude female goblins.  You try hard to avoid puking." CR CR>)
    (<==? .RARG ,M-FLASH>
      <TELL "The ">
      <NPC-LINK "Goblin King">
      <TELL " is here." CR CR>
      <TELL "You can go ">
      <EXIT-LINK "out">
      <TELL "." CR>)
    (<AND <==? .RARG ,M-BEG><VERB? MOO>>
      <TELL "You moo. The Goblin King nods." CR>
    )>>

<OBJECT STATUES
  (DESC "statues")
  (SYNONYM STATUE STATUES)
  (IN INSIDE-GOBLIN-LAIR)
  (FLAGS NDESCBIT PLURALBIT TAKEBIT TRYTAKEBIT)
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
  (FLAGS PERSONBIT NARTICLEBIT NDESCBIT)
  (ACTION GOBLIN-KING-R)>

<ROUTINE GOBLIN-KING-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"An officious-looking, double-chinned goblin monarch sits royally atop a throne
of deer hide." CR>)
    (<VERB? SPEAK>
      <TELL
"\"Hoo hoo hoo!">
      <COND
        (<NOT <FSET? ,GOBLIN-SPIT ,TOUCHBIT>>
          <TELL
"  Goblinz so grate, our spit is assid!  We spit on yu if yu make
us angree!  If yu hav tiny statyoo of jade, we giv yu nice thing!">)>
      <TELL "\"" CR>
    )
    (<VERB? THINK-ABOUT>
      <TELL 
"Just speak to him. If he wants something, he'll pretty much say so." CR>
    )>>

<ROUTINE GIFT-OF-KING-R ()
  <INCREMENT-SCORE 40>
  <REMOVE ,JADE-STATUETTE>
  <MOVE ,GOBLIN-SPIT ,PLAYER>
  <FSET ,GOBLIN-SPIT ,TOUCHBIT>
  <THIS-IS-IT ,GOBLIN-SPIT>
  <TELL
"\"Ooooo!  You find goblinn lost statyoo!  We giv yu wun jar of spit!\"" CR>
>

<ROUTINE OTHER-GIFT-R ()
  <INCREMENT-SCORE 40>
  <REMOVE ,DUCK-TURD>
  <MOVE ,GRAPPLING-HOOK ,PLAYER>
  <FSET ,GRAPPLING-HOOK ,TOUCHBIT>
  <THIS-IS-IT ,GRAPPLING-HOOK>
  <TELL
"\"Ooooo!  GIMME GIMME GIMME!  Duck turd favorite goblin food!  We giv yu
grapple hook!\"" CR>
>

;" ************************** LAND OF THE NECROYAKS *****************************"

<OBJECT LAND-OF-NECROYAKS
  (PNAME "LAND-OF-NECROYAKS")
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
      <TELL "There is a ">
      <OBJECT-LINK "sign">
      <TELL " here.|" CR>
      <TELL "You can go ">
      <EXIT-LINK "north">
      <TELL " or ">
      <EXIT-LINK "south">
      <TELL "." CR>)>>

<OBJECT NECROYAKS-SIGN
  (IN LAND-OF-NECROYAKS)
  (DESC "sign")
  (SYNONYM SIGN)
  (FLAGS TAKEBIT TRYTAKEBIT NDESCBIT)
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

;" ************************** AMBUSH POINT **************************************"

<GLOBAL CLIFF-FACE-BLOCKS "The cliff face blocks your way.">
<OBJECT AMBUSH-POINT
  (PNAME "AMBUSH-POINT")
  (IN ROOMS)
  (DESC "Deep in NecroYak Territory")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (ACTION AMBUSH-POINT-R)
  (SOUTH TO LAND-OF-NECROYAKS)
  (NORTH "The cliff face blocks your way.")
  (NE "The cliff face blocks your way.")
  (NW "The cliff face blocks your way.")
  (SW "The cliff face blocks your way.")
  (SE "The cliff face blocks your way.")
  (EAST "The cliff face blocks your way.")
  (WEST "The cliff face blocks your way.")
  (UP "It's steep -- you can't climb.")
  (DOWN "It's steep -- you can't climb.")
>

<ROUTINE AMBUSH-POINT-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL "A ">
      <OBJECT-LINK "cliff face">
      <TELL 
" blocks your way here.  It's steep -- you can't climb.  If you want to continue, you'll have to ">
      <EXIT-LINK "search">
      <TELL " the face." CR CR>
    )
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <EXIT-LINK "south">
      <TELL "." CR>
    )
    (<AND <==? .RARG ,M-BEG> <VERB? CLIMB-MOD> >
      <TELL "It's steep -- you can't climb." CR>
      <RTRUE>)>>

<ROUTINE YAKS-KILL-R ()
  <TELL 
"The NecroYaks recognize you as a cow, then jump out and kill you." CR CR>
  <JIGS-UP ,LOSE-TEXT>>

<ROUTINE YAKS-LOVE-R ()
  <INCREMENT-SCORE 40>
  <TELL 
"The NecroYaks jump out and search you for acid.  They find your goblin spit,
take it, and run off.  But one of them drops a phoenix feather, and you scoop it
up unnoticed.  By the way, there's no way to go farther this way unless you're a
yak." CR>
  <REMOVE ,GOBLIN-SPIT>
  <MOVE ,WING-FEATHER ,PLAYER>
  <THIS-IS-IT ,WING-FEATHER>
>

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

<OBJECT CLIFF-FACE
  (DESC "cliff face")
  (SYNONYM CLIFF FACE)
  (ARTICLE "the")
  (IN AMBUSH-POINT)
  (ACTION CLIFF-R)
  (FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
>

<ROUTINE CLIFF-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"It's a cliff; you could climb it, but it might be a difficult climb." CR>
    )
    (<VERB? TAKE>
      <TELL
"If you want to climb the cliff, say so!" CR>
    )
    (<VERB? CLIMB>
      <TELL
"After a difficult climb, you reach the top.  You're very pleased with yourself.
 Unfortunately, the ledge crumbles beneath you and you plummet back to the
ground." CR>
    )
    (<VERB? SEARCH>
      <V-SEARCH-THE-ROOM>
      <RTRUE>
    )
  >
>


;" ************************** PHOENIX MOUNTAIN PASS *****************************"

<OBJECT PHOENIX-MOUNTAIN-PASS
  (PNAME "PHOENIX-MOUNTAIN-PASS")
  (IN ROOMS)
  (DESC "Phoenix Mountain Pass")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (ACTION PHOENIX-MOUNTAIN-PASS-R)
  (WEST TO ZEKES-FARM)
  (EAST TO PHOENIX-PEAK)
  (UP "Try climbing.")>

<ROUTINE PHOENIX-MOUNTAIN-PASS-R (RARG)
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL
"The towering "><OBJECT-LINK "mountains"><TELL " surround you on all sides but back to your west. 
Passage farther east is remotely possible, should you be brave or foolhardy
enough to try it." CR CR>)
    (<==? .RARG ,M-FLASH>
      <TELL "You can go ">
      <EXIT-LINK "west">
      <TELL " or ">
      <EXIT-LINK "east">
      <TELL "." CR>)>>

<OBJECT MOUNTAINS
  (DESC "mountains")
  (IN PHOENIX-MOUNTAIN-PASS)
  (FLAGS PLURALBIT NDESCBIT TAKEBIT TRYTAKEBIT NDESCBIT)
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
      <CLIMB-THEM-R>)
    (<VERB? THINK-ABOUT>
      <TELL "You think they could be climbed, with the proper tool." CR>)>>

<ROUTINE CLIMB-THEM-R ()
  <COND
    (<HELD? ,GRAPPLING-HOOK>
      <INCREMENT-SCORE 19>
      <REMOVE ,GRAPPLING-HOOK>
      <MOVE ,PURPLE-PAINT ,PLAYER>
      <THIS-IS-IT ,PURPLE-PAINT>
      <TELL 
"On top of the mountain, you find a bunch of purple paint, which you take. 
After descending again, you ditch your grappling hook." CR>
    )
    (T
      <TELL 
"Those particular mountains are too steep." CR>)>>

;" ************************** PHOENIX PEAK **************************************"

<OBJECT PHOENIX-PEAK
  (PNAME "PHOENIX-PEAK")
  (IN ROOMS)
  (DESC "Phoenix Peak")
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (ACTION PHOENIX-PEAK-R)
  (WEST TO PHOENIX-MOUNTAIN-PASS)>

<ROUTINE PHOENIX-PEAK-R (RARG)
  <COND
    (<==? .RARG ,M-FLASH>
      <TELL
"After hard hours of climbing, you finally reach the summit of Phoenix Peak. 
Here, in all its glory, sits the ">
      <NPC-LINK "Resplendent Magnificent Phoenix">
      <TELL "." CR CR>
      <TELL "You can go ">
      <EXIT-LINK "west">
      <TELL "." CR>)
    (
      <AND <==? .RARG ,M-BEG><VERB? MOO>>
        <TELL "You moo..." CR CR>
        <PERFORM ,V?SPEAK ,PHOENIX>
        <RTRUE>
    )>>

<OBJECT PHOENIX
  (DESC "the Resplendent Magnificent Phoenix")
  (SYNONYM PHOENIX PHOENI)
  (ADJECTIVE RESPLE RESPLENDENT MAGNIF MAGNIFICENT)
  (IN PHOENIX-PEAK)
  (FLAGS PERSONBIT NDESCBIT NARTICLEBIT)
  (ACTION PHOENIX-R)>

<ROUTINE PHOENIX-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"The Resplendent Magnificent Phoenix's visage is so brilliant that it hurts to
look at it." CR>
    )
    (<VERB? SPEAK>
      <TELL
"The Resplendent Magnificent Phoenix ">
      <COND
        (<HELD? ,FLY-SCROLL>
          <TELL "does not reply." CR>
        )
        (T
          <TELL "demands to know ">
          <ITALICIZE "why">
          <TELL
" such a weakling as you has come here!  \"If you do not have my wing feather
with you, I'm afraid I must ask you to leave ">
          <ITALICIZE "immediately!">
          <TELL 
"  Now, do you have my wing feather or not?\" -- " CR>
          <BOLDIZE "Yes">
          <TELL " or ">
          <BOLDIZE "No">
          <TELL "? ">
          <COND
            (<YES?>
              <CRLF>
              <COND
                (<HELD? WING-FEATHER>
                  <PHOENIX-PROC-R>
                )
                (T
                  <PHOENIX-KILL-R>
                )
              >
            )
            (T
              <CRLF>
              <TELL
"\"Then leave me immediately, as I do not appreciate company.\"" CR>
            )
          >
        )
      >
    )
    (<VERB? THINK-ABOUT>
      <TELL "Just speak to him." CR>
    )
    (<VERB? GIVE>
      <COND
        (<==? ,PRSO ,WING-FEATHER>
          <PHOENIX-PROC-R>
          <RTRUE>
        )
      >
    )
  >
>

<ROUTINE PHOENIX-PROC-R ()
  <INCREMENT-SCORE 40>
  <TELL 
"\"Thank you; you have found my wing feather.  In the wrong hands, that could
have been very dangerous.  I will give you this 'fly' scroll to compensate you
for your hard work.  ">
  <BOLDIZE "Use">
  <TELL " the scroll to fly, but it will only work once.\"" CR>
  <MOVE ,FLY-SCROLL ,PLAYER>
  <THIS-IS-IT ,FLY-SCROLL>
  <REMOVE ,WING-FEATHER>
>

<ROUTINE PHOENIX-KILL-R ()
  <TELL 
"\"Then give it to me quickly!  What..... You don't have my wing feather at all,
do you?  You shammer.  I was going to dismiss you without hurting you, but I'm
afraid now I'll have to kill you.\"||The Resplendent Magnificent Phoenix bats
you with one claw.  You roll back down the mountainside, finally coming to a
complete stop looking very much like a well-done steak." CR CR>
  <JIGS-UP ,LOSE-TEXT>>

;" ************************** END OF ROOM DESCRIPTIONS **************************"

<GLOBAL WIN-TEXT "Congratulations, you have found out that you were better off
where you started anyway.  The grass here is brown and crackly.  Too bad!
 And... OH NO!  Now you're trapped here, alone with the NecroYaks!  Stay tuned
for \"The Adventures of Koww the Magician II -- Escape from the NecroYaks!\"">

<GLOBAL LOSE-TEXT "Idiot.  You die.  HA HA HA HA HA!">

<ROUTINE FINISH-R ()
  <COND
    (<NOT <==? <LOC ,PLAYER> ,KOWWS-CHASM>>
      <TSD>)
    (<HELD? FLY-SCROLL>
      <CALL END-R>)
    (T
      <TELL "Maybe you'll find it someday, but you don't have it today.  You
stupid cow." CR>)>>

<ROUTINE END-R ()
  <INCREMENT-SCORE 40>
  <TELL "You fly up and over the chasm!" CR CR>
  <TELL ,WIN-TEXT CR>
  <TELL "|[PRESS RETURN OR ENTER TO VIEW YOUR SCORE.]">
  <READLINE>
  <CRLF>
  <TELL "You scored ">
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
  <CRLF>
  <ADD-JS-SCRIPT "removeAllLinks();$('#toolbar').hide();">
  <QUIT>>

; *** TEXT ROUTINES ***

<ROUTINE BOLDIZE (TEXT)
  <HLIGHT 2>
  <TELL .TEXT>
  <HLIGHT 0>>
  
;"########## GLOBALS ##########"

<OBJECT CUD
  (IN GLOBAL-OBJECTS)
  (DESC "your cud")
  (SYNONYM CUD)
  (ADJECTIVE MY)
  (LDESC "You can't see your cud, it's regurgitated into your mouth!")
  (FLAGS NARTICLEBIT PARTBIT)
  (ACTION CUD-R)>
  
<ROUTINE CUD-R ()
  <COND
    (<VERB? EAT>
      <TELL "You chew your cud." CR>)
    (<VERB? SMELL>
      <SILLY>)>>

<OBJECT TAIL
  (IN GLOBAL-OBJECTS)
  (DESC "your tail")
  (SYNONYM TAIL)
  (ADJECTIVE MY)
  (FLAGS NARTICLEBIT PARTBIT)>


<OBJECT HOOVES
  (IN GLOBAL-OBJECTS)
  (DESC "your hooves")
  (SYNONYM HOOF HOOVES)
  (ADJECTIVE MY FRONT LEFT BACK RIGHT)
  (FLAGS PLURALBIT NARTICLEBIT)>

<OBJECT KOWW-PACK
  (IN GLOBAL-OBJECTS)
  (DESC "your Koww-pack")
  (SYNONYM PACK KOWW-PACK)
  (ADJECTIVE MY KOWW)
  (FLAGS NARTICLEBIT TAKEBIT TRYTAKEBIT)
  (ACTION KOWW-PACK-R)>
  
<ROUTINE KOWW-PACK-R ()
  <COND
    (<PRSO? ,KOWW-PACK>
      <TELL
        <PICK-ONE-R
          <PLTABLE
            "You don't have your KOWW-pack."
            "There is no KOWW-pack in this game."
            "You didn't bring a KOWW-pack."
          >
        >
      >
      <AND <NOT <FSET ,KOWW-PACK ,INVISIBLE>>
        <TELL
          <PICK-ONE-R
            <PLTABLE
              " I was just kidding about that."
              " That was just a joke."
            >
          >
        >
      >
      <CRLF>
    )
  >
>

;"######## LOCAL GLOBALS ########"

<OBJECT GOBLINS
  (IN LOCAL-GLOBALS)
  (DESC "goblins")
  (FLAGS PLURALBIT NDESCBIT)
  (ACTION GOBLINS-R)
  (SYNONYM GOBLINS)
  (ADJECTIVE twenty)>

<ROUTINE GOBLINS-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"They are very ugly, and they're all watching you closely." CR>)
    (<VERB? SPEAK>
      <SILLY>)>>

<OBJECT GOBLINS-SMELL
  (IN LOCAL-GLOBALS)
  (DESC "goblins")
  (SYNONYM GOBLIN GOBLINS)
  (FLAGS PLURALBIT NARTICLEBIT)
  (ACTION GOBLINS-SMELL-R)>
  
<ROUTINE GOBLINS-SMELL-R ()
  <COND
    (<VERB? EXAMINE>
      <COND
        (<NOT <==? <LOC ,PLAYER> ,GOBLIN-LAIR ,INSIDE-GOBLIN-LAIR>>
          <TELL "You can't see them from here." CR>)>)
    (<VERB? SMELL>
      <COND
        (<NOT <==? <LOC ,PLAYER> ,GOBLIN-LAIR ,INSIDE-GOBLIN-LAIR>>
          <TELL "The stench is coming from the south." CR>)
        (T
          <TELL "They STINK!!!" CR>)>)>>


<OBJECT FARMER-SMELL
  (IN LOCAL-GLOBALS)
  (DESC "Farmer Zeke")
  (SYNONYM MAN HUMAN FARMER ZEKE)
  (ADJECTIVE FARMER)
  (FLAGS PERSONBIT NARTICLEBIT)
  (ACTION FARMER-SMELL-R)>

<ROUTINE FARMER-SMELL-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "You can't see him from here." CR>)
    (<VERB? SMELL>
      <COND
        (<==? <LOC, ZEKE> ,HERE>
          <TELL "He smells like magic milk." CR>)
        (T
          <TELL "He seems to be... in the silo." CR>)>)>>

;"######## Action handler for the player. (MODIFIED) ######## "
<ROUTINE PLAYER-F ()
    <COND (<N==? ,PLAYER ,PRSO>
            <COND
              (<VERB? DROP>
                <COND
                  (<PRSO? ,KOWW-PACK>
                    <KOWW-PACK-R>
                    <RTRUE>)>)
              (T
                <RFALSE>)>)
          (<VERB? EXAMINE>
            <COND
             (<==? ,PAINTED ,T>
               <PRINTR "You are covered in purple paint.">)
             (T
               <PRINTR "You look like you're up for an adventure.">)>)>>

<ROUTINE GET-ARTICLE (OBJ "OPT" INDEF)
  <COND
    (<OR <FSET? .OBJ ,NARTICLEBIT><FSET? .OBJ ,PERSONBIT><FSET? .OBJ ,FEMALEBIT>>
      <RETURN "">
    )
    (<==? .INDEF T>
      <COND
        (<FSET? .OBJ ,VOWELBIT>
          <RETURN "an ">
        )
        (ELSE
          <RETURN "a ">
        )
      >
    )
    (ELSE
      <RETURN "the ">
    )
  >
>