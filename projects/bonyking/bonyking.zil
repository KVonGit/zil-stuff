"The Bony King of Nowhere - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
"The Bony King of Nowhere (ZIL Port)
|An Interactive Adventure by Luke A. Jones
|Copyright (c) 2017, 2025 Luke A. Jones. All rights reserved.
|v0.4-alpha">

<ROUTINE GO ()
  <SETG MODE ,VERBOSE>
  <CRLF> <CRLF>
  <TELL 
"You are a citizen of the land of Nowhere, and you are given an urgent letter to deliver to the King.
Navigate your way through the strange and twisted landscape to the capital city of Lost and gain
access to the King's castle." CR CR "This is a casual text adventure game in the classic parser
style.||Note: This game was an entry in The 2017 Spring Thing Festival of Interactive Fiction
(springthing.net)" CR CR>
  <ITALICIZE "*** Type 'hints' at any time for help. ***">
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <SETG HERE ,HOVEL>
  <MOVE ,PLAYER ,HERE>
  <QUEUE I-DYLAN -1>
  <V-LOOK>
  <MAIN-LOOP>
  >
<COMPILATION-FLAG DEBUGGING-VERBS T>
<INSERT-FILE "parsermod">

<SET REDEFINE T>

;----------------------------------------------------------------------
;"#################### COMMANDS ####################"
;----------------------------------------------------------------------

<SYNTAX SHARPEN OBJECT = V-SHARPEN>

<ROUTINE V-SHARPEN ()
  <TELL "You can't sharpen " T, PRSO "." CR>>

<SYNTAX HACK OBJECT = V-HACK>

<ROUTINE V-HACK ()
  <TELL "You can't hack " T, PRSO "." CR>>
  
<VERB-SYNONYM HACK CUT CHOP>

<SYNTAX LIGHT OBJECT = V-LIGHT>

<VERB-SYNONYM LIGHT BURN IGNITE>

<ROUTINE V-LIGHT ()
  <TELL "You can't light " T, PRSO "." CR>>

<SYNTAX SPEAK TO OBJECT = V-SPEAK>

<VERB-SYNONYM SPEAK TALK>

<ROUTINE V-SPEAK ()
  <TELL "There is no reply." CR>>

<SYNTAX PET OBJECT = V-PET>
<SYNTAX PAT OBJECT = V-PAT>
<SYNTAX STROKE OBJECT = V-STROKE>

<ROUTINE PET-F (WORD)
  <TELL "You can't " .WORD " " T, PRSO "." CR>>

<ROUTINE V-PET () <PET-F "pet">>
<ROUTINE V-PAT () <PET-F "pat">>
<ROUTINE V-STROKE () <PET-F "stroke">>

<SYNTAX TIE OBJECT = V-TIE>

<ROUTINE V-TIE ()
  <NOT-POSSIBLE "ty">
  <RTRUE>
>

<SYNTAX THROW OBJECT = V-THROW>

<ROUTINE V-THROW ()
  <V-DROP>
>

;----------------------------------------------------------------------
;"#################### YOUR HOVEL ####################"
;----------------------------------------------------------------------

<OBJECT HOVEL
    (IN ROOMS)
    (DESC "Your Hovel")
    (FLAGS LIGHTBIT)
    (LDESC 
"You are in your hovel in the northernmost borderlands of the Kingdom of Nowhere. It is a round
wattle and daub hut. There is a fireplace in the middle with a hole in the thatch roof above it
acting as a chimney.||Around the circumference of the room there are a few sticks of furniture and
rags that represent the totality of your worldly possessions.||You can go out.")
    (OUT TO NMEADOW)
    (ACTION HOVEL-R)>

<ROUTINE HOVEL-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
     <MOVE ,DYLAN ,HERE>)>>

<OBJECT CHEST
    (DESC "Battered Wooden Chest")
    (SYNONYM BATTER WOODEN CHEST)
    (IN HOVEL)
    (FLAGS CONTBIT OPENABLEBIT)
    (ACTION CHEST-R)>

<ROUTINE CHEST-R ()
    <COND
      (<VERB? EXAMINE>
        <TELL 
"An ancient wooden chest that has been repeatedly patched and repaired. You'll bepleased to know
there is no lock." CR>)>>

<OBJECT BLUNT-AXE
    (DESC "axe")
    (SYNONYM AXE)
    (ADJECTIVE BLUNT)
    (IN CHEST)
    (FLAGS TAKEBIT VOWELBIT)
    (ACTION BLUNT-AXE-R)>

<ROUTINE BLUNT-AXE-R ()
  <COND 
    (<VERB? EXAMINE>
      <TELL 
"An axe with an arms length wooden haft and a steel head with the letter L and the pattern of a rose
embossed on it. It is your prized (and only) possession given to you by your father. It's blade is a
sharp as Jack after a busy day." CR>)
    (<VERB? SHARPEN>
      <COND
        (<NOT <IN? ,BLUNT-AXE ,PLAYER>>
          <TELL "You don't have that." CR>)
        (<IN? ,PLAYER ,HOVEL>
          <REMOVE ,BLUNT-AXE>
          <MOVE , SHARP-AXE ,PLAYER>
          <THIS-IS-IT ,SHARP-AXE>
          <TELL 
"You walk over to the hearthstones and sharpen the axe blade on one of them. After aminute or so, it
gleams with a wicked edge. It is now an axe-is of evil." CR>)
        (T
          <TELL "There is nothing here to sharpen it on." CR>)>)>>

<OBJECT SHARP-AXE
  (DESC "axe")
  (SYNONYM AXE)
  (ADJECTIVE SHARP)
  (FLAGS TAKEBIT VOWELBIT)
  (ACTION SHARP-AXE-R)>

<ROUTINE SHARP-AXE-R ()
  <COND 
    (<VERB? EXAMINE>
      <TELL 
"An axe with an arms length wooden haft and a sharpened steel head with the letter L and the pattern
of a rose embossed on it. It is your prized (and only) possession given to you by your father. It's
blade is sharp as frost." CR>)
    (<VERB? SHARPEN>
      <TELL "It's already sharp." CRLF>)
    (<VERB? DROP>
      <TELL "You drop the useful looking axe, a wise move I'm sure." CR>
      <MOVE ,SHARP-AXE ,HERE>)>>

<OBJECT SHOVEL
  (IN HOVEL)
  (DESC "shovel")
  (SYNONYM SHOVEL)
  (FLAGS NDESCBIT)
  (ACTION SHOVEL-R)>

<ROUTINE SHOVEL-R ()
    <COND 
      (<VERB? EXAMINE>
        <TELL "A small wooden shovel that you use for removing ashes. It's a ground-breaking design." CR>)
      (<VERB? TAKE>
        <COND (<HELD? SHOVEL>
          <TELL "You already have the shovel." CR>)
        (<IN? ,SHOVEL ,HERE>
          <FCLEAR ,SHOVEL ,NDESCBIT>
          <MOVE ,SHOVEL ,PLAYER>
          <TELL "Taken." CR>)>)>>

<OBJECT RAGS
    (IN HOVEL)
    (DESC "rags")
    (SYNONYM RAGS)
    (FLAGS PLURALBIT NDESCBIT)
    (ACTION RAGS-R)>

<ROUTINE RAGS-R ()
  <COND
    (<VERB? EXAMINE> 
      <COND
        (<HELD? ,RAGS>
          <TELL "A few rags of cloth." CR>)
        (T
          <TELL "A pile of rags that were once clothes, now too threadbare to wear." CR>)>)
    (<VERB? TAKE>
      <COND
        (<HELD? RAGS>
          <TELL "You already have the rags." CR>)
        (T
          <FCLEAR ,RAGS ,NDESCBIT>
          <MOVE ,RAGS ,PLAYER>
          <TELL "Taken." CR>)>)
    (<VERB? HACK>
      <TELL "That would be axe-zessive!" CR>)>>
      
<OBJECT FIREPLACE
  (IN HOVEL)
  (DESC "fireplace")
  (SYNONYM FIREPL FIRE)
  (FLAGS NDESCBIT)
  (ACTION FIREPLACE-R)>

<ROUTINE FIREPLACE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"A round circle of flat stones with the ashen remains of last night's fire smouldering in the middle.">
      <COND
        (<IN?, SHOVEL, HOVEL>
          <TELL " Leaning against the fireplace is a shovel.">)>
      <CRLF>)
    (<VERB? LIGHT>
      <TELL 
"You could rekindle the fire but you decide not to as you are low on fuel. Besides, you need to get
out and about." CR>)>>

<OBJECT DYLAN
  (IN HOVEL)
  (DESC "your dog")
  (FLAGS NARTICLEBIT NALLBIT PERSONBIT)
  (SYNONYM DYLAN DOG)
  (ACTION DYLAN-R)>
  
<ROUTINE DYLAN-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"It's your faithful canine companion. He's an ageing Boxer mongrel of some sort. He has tan brown
fur with a white patch on his chest. He's seen a few too many scrapes and doesn't smell too sweet,
but you love him dearly and he's called Dylan." CR>)
    (<VERB? TAKE>
      <TELL "You don't need to carry him. He'll follow you anywhere." CR>)
    (<VERB? HACK ATTACK>
      <TELL "He's your only friend in the world. You'd never hurt him." CR>)
    (<VERB? PET PAT STROKE>
      <TELL 
"Dylan nuzzles against your leg and looks up to you with doleful eyes, his tail wagging expectantly.">
      <COND
        (<NOT <FSET? ,HAIR-OF-DOG ,TOUCHBIT>>
          <TELL " Some of his moulting hair collects in your hand. You shove it in your pocket." CR>
          <MOVE ,HAIR-OF-DOG ,PLAYER>
          <FSET ,HAIR-OF-DOG ,TOUCHBIT>)>
      <CRLF>)
    (<VERB? SPEAK>
      <TELL "Dylan looks up to you and barks excitedly." CR>)>>

<OBJECT HAIR-OF-DOG
  (DESC "dog hair")
  (SYNONYM HAIR)
  (ADJECTIVE DOG)
  (FLAGS TAKEBIT NARTICLEBIT)
  (ACTION HAIR-OF-DOG-R)>

<ROUTINE HAIR-OF-DOG-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "A few strands of Dylan's brown and white hair." CR>)>>

<ROUTINE I-DYLAN (RARG)
  <MOVE ,DYLAN ,HERE>
  <COND
    (<==? ,PRSA ,V-WALK>
      <TELL "Your dog is here." CR>)>>

<OBJECT FURNITURE
  (IN HOVEL)
  (DESC "furniture")
  (SYNONYM FURNIT)
  (FLAGS NDESCBIT)
  (ACTION FURNITURE-R)>

<ROUTINE FURNITURE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"Furniture might be a rather grand term what consists of a filthy straw bed and a battered wooden
chest." CR>)>>

<OBJECT STONES
  (IN HOVEL)
  (DESC "stones")
  (SYNONYM STONES WHETST)
  (FLAGS PLURALBIT NDESCBIT)
  (ACTION STONES-R)>

<ROUTINE STONES-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "A circle of flat whetstones bearing heavy scratch marks." CR>)>>

<OBJECT STRAW-BED
  (IN HOVEL)
  (DESC "straw bed")
  (SYNONYM BED)
  (ADJECTIVE FILTHY STRAW)
  (FLAGS NDESCBIT)
  (ACTION STRAW-BED-R)>

<ROUTINE STRAW-BED-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"Several large rectangular bales of hay lashed together. It is blackened with grime and splattered
with mud." CR>)
    (<VERB? HACK>
      <TELL "That would be axe-zessive!" CR>)>>

<OBJECT ROOF
  (IN HOVEL)
  (DESC "roof")
  (SYNONYM ROOF)
  (FLAGS NDESCBIT)
  (ACTION ROOF-R)>

<ROUTINE ROOF-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"The circular roof is made from straw thatch, with a small hole in the centre to let out the smoke
from the fire." CR>)>>

<OBJECT HOLE
  (IN HOVEL)
  (DESC "hole")
  (SYNONYM HOLE)
  (FLAGS NDESCBIT)
  (ACTION HOLE-R)>

<ROUTINE HOLE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL 
"A small hole in the centre of the roof. You made it to let out the smoke from the fire." CR>)>>

<OBJECT SCRATCH-MARKS
  (IN HOVEL)
  (DESC "scratch marks")
  (SYNONYM SCRATC MARKS)
  (FLAGS NDESCBIT)
  (ACTION SCRATCH-MARKS-R)>

<ROUTINE SCRATCH-MARKS-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "Heavy scratch marks made from the repetitive action of sharpening tools." CR>)>>

<OBJECT HAY
  (DESC "hay")
  (IN HOVEL)
  (FLAGS NDESCBIT)
  (SYNONYM HAY STRAW BALE)
  (ACTION HAY-R)>

<ROUTINE HAY-R ()
  <COND
    (<VERB? TAKE>
      <TELL "You decide to leave the filthy hay where it is." CR>)>>

;----------------------------------------------------------------------
;"###################### NORTHERN MEADOW ######################"
;----------------------------------------------------------------------

<OBJECT NMEADOW
  (DESC "Northern Meadow")
  (IN ROOMS)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (IN TO HOVEL)
  (SOUTH SMEADOW)
  (ACTION NMEADOW-R)>

<ROUTINE NMEADOW-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
     <MOVE ,DYLAN ,HERE>)>
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL 
"You are in the meadow outside your hovel, several acres of wild grassland and wild flowers. You may
be dirt poor, but the beauty of the landscape is some consolation.||You can go in our south." CR>
      <COND
        (<NOT <FSET? ,HERE ,TOUCHBIT>>
          <TELL CR 
"As you step out of your home there is a beating of wings above your head. Looking up, you see a
pigeon rapidly disappearing out of sight, and a letter flutters to your feet. You pick it up." CR CR 
"On the wind, you can hear a distant shout of what sounds like, \"fuck yooouuuu...\" coming from the
pigeon's direction before it disappears from sight." CR>
          <MOVE ,LETTER ,PLAYER>)>)>>

<OBJECT LETTER
  (DESC "letter")
  (SYNONYM LETTER)
  (FLAGS TAKEBIT)
  (ACTION LETTER-R)>

<ROUTINE LETTER-R ()
  <COND
    (<VERB? DROP>
      <TELL "Remembering the threat of execution, you decide not to drop the letter." CR>)
    (<VERB? READ>
      <TELL 
"You're dying to know what's in the letter, but the instructions written on it forbid you from doing
so. You can examine it." CR>)
    (<VERB? EXAMINE>
      <TELL 
"The letter is addressed to the Bony King of Nowhere, at his palace in the capital Lost, many miles
to the south. On the reverse is written:|\"">
      <ITALICIZE 
"If found please deliver personally to the King, the contents are confidential and you are forbidden
from reading them. Failure to comply with either of these requests will result in summary execution.">
      <TELL 
"\"||Well that's just perfect you think, you've always hated a) the capital, b) the monarchy, and c)
the south in general." CR>)
    (<VERB? OPEN>
      <TELL "You can't open it, the King will have you killed!" CR>)
    (<VERB? CLOSE>
      <TELL "It's already closed.">)
    (<VERB? HACK>
      <COND
        (<HELD? SHARP-AXE>
          <TELL 
"You consider chopping the letter into pieces, but the King has spies everywhere and you value your
life." CR>)
        (<HELD? BLUNT-AXE>
          <TELL "Your axe is too blunt (and it's probably not a good idea)." CR>)
        (T
          <TELL "You need a tool for that." CR>)>)>>

<OBJECT WILD-FLOWERS
  (IN NMEADOW)
  (DESC "wild flowers")
  (SYNONYM FLOWERS)
  (ADJECTIVE WILD)
  (LDESC "There is a multitude of beautiful wild flowers, bowing gently in the breeze.")
  (FLAGS NDESCBIT)
  (ACTION WILD-FLOWERS-R)
>

<ROUTINE WILD-FLOWERS-R ()
  <COND
    (<VERB? TAKE>
      <TELL "You decide to leave the flowers for the visiting bees to enjoy." CR>
    )
  >
>

;----------------------------------------------------------------------
;"###################### SOUTHERN MEADOW ######################"
;----------------------------------------------------------------------

<OBJECT SMEADOW
  (DESC "Southern Meadow")
  (IN ROOMS)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH NMEADOW)
  (SOUTH NWOODS)
  (ACTION SMEADOW-R)>

<ROUTINE SMEADOW-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
     <MOVE ,DYLAN ,HERE>)>
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL 
"You are in the Southern Meadow, on the edge of the Northern Woods." CR>)>>

<OBJECT FALLEN-TREE
  (SYNONYM TREE)
  (ADJECTIVE FALLEN)
  (DESC "fallen tree")
  (IN SMEADOW)
  (ACTION FALLEN-TREE-R)
>

<ROUTINE FALLEN-TREE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "" CR>
    )
    (<VERB? TAKE>
      <TELL "" CR>
    )
    (<VERB? HACK>
      <COND
        (<HELD? ,SHARP-AXE>
          <TELL "You swing your trusty axe and reduce the tree to four body-length logs." CR>
          <FCLEAR ,LOGS ,INVISIBLE>
          <THIS-IS-IT ,LOGS>
          <FSET ,FALLEN-TREE ,INVISIBLE>
        )
        (<HELD? ,BLUNT-AXE>
          <TELL "You swing your axe at the fallen tree, but it's too blunt to chop it." CR>
        )
        (ELSE
          <TELL "You need a tool for that." CR>
        )
      >
    )
  >
>

<OBJECT LOGS
  (SYNONYM LOGS)
  (DESC "logs")
  (IN SMEADOW)
  (FLAGS TAKEBIT INVISIBLE PLURALBIT)
  (ACTION LOGS-R)
>

<ROUTINE LOGS-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "Four body-length sized logs from a poplar tree." CR>
    )
    (<VERB? DROP>
      <TELL "The four logs strike the ground making a rhythm... a log-a-rhythm." CR>
      <MOVE ,LOGS, HERE>
    )
    (<VERB? TIE>
      <COND
        (<HELD? ,ROPE>
          <TELL 
"You lash the logs together with the rope, you now have what could very generously be described as
a raft. Dylan eyes it suspiciously.." CR>
          <MOVE ,RAFT ,PLAYER>
          <MOVE ,ROPE <>>
          <MOVE ,LOGS <>>
        )
        (<HELD? ,REEDS>
          <TELL "The reeds are not strong enough to tie the logs with." CR>
        )
        (ELSE
          <TELL "You need something to tie them with." CR>
        )
      >
    )
    (<VERB? HACK>
      <COND
        (<HELD? ,SHARP-AXE>
          <TELL
"You consider reducing the logs to matchwood, but decide they may prove more useful in their current
logish formation." CR>
        )
        (<HELD? ,BLUNT-AXE>
          <TELL "You swing your axe at the logs, but it's too blunt to chop them." CR>
        )
        (ELSE
          <TELL "You would need a tool for that." CR>
        )
      >
    )
  >
>

<OBJECT APPLE
  (DESC "apple")
  (SYNONYM APPLE)
  (IN SMEADOW)
  (FLAGS TAKEBIT VOWELBIT)
  (ACTION APPLE-R)
>

<ROUTINE APPLE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "A medium sized apple of the Cox's variety, it is mottled green and red." CR>
    )
    (<VERB? EAT>
      <TELL "You detest fruit so you decide to not eat the apple." CR>
    )
    (<VERB? HACK>
      <COND
        (<HELD? ,SHARP-AXE>
          <TELL "That would be fruitless." CR>
        )
        (<HELD? ,BLUNT-AXE>
          <TELL "Your axe is blunt." CR>
        )
        (ELSE
          <TELL "You would need a tool for that." CR>
        )
      >
    )
    (<VERB? THROW>
      <TELL 
"You throw the apple, as soon as it's in the air Dylan is off like a shot, he catches it and returns
it to you." CR>
    )
    (<AND <VERB? GIVE><PRSI? ,HORSE>>
      <TELL 
"You place the apple in the flat palm of your hand and offer it up to the horse. Its lips tickle
your hand as it picks it up, it munches it noisily. You smell the tart tang of the apple as it's
masticated.||The horse eyes you and gently snorts. You've made a friend.">
      <SETG HORSE-MATES T>
      <MOVE ,APPLE <>>
    )
  >
>

;"TODO - PLACEHOLDER"

<GLOBAL HORSE-MATES <>>
<OBJECT HORSE
>

;----------------------------------------------------------------------
;"###################### NORTHERN WOODS ######################"
;----------------------------------------------------------------------

<OBJECT NWOODS
  (DESC "Northern Woods")
  (IN ROOMS)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH SMEADOW)
  (SOUTH WOODLAND-CLEARING)
  (ACTION NWOODS-R)>


<ROUTINE NWOODS-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
     <MOVE ,DYLAN ,HERE>)>
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL 
"You are on a path in the woods that runs North to South, the trees are densely packed, shards of
sunlight stab through the small gaps in the canopy, it is humid in here. The floor of the forest is
thick with leaf litter from countless autumns.||You can go north or south." CR>)>>



<OBJECT GNOME-CHOMPSKY
  (SYNONYM GNOME CHOMPSKY)
  (DESC "Gnome Chompsky")
  (FLAGS PERSONBIT NARTICLEBIT)
  (ACTION GNOME-CHOMPSKY-R)
>

<ROUTINE GNOME-CHOMPSKY-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"He's just over a foot tall, including his bright red brimless conical cap. He's wearing a pastel
blue jacket with a belt fastened at the middle, black trousers and comically big (relative to his
stature) black boots. ||He has a white beard and a mischievous twinkle in his eyes." CR>
    )
    (<VERB? HACK>
      <COND
        (<HELD? ,SHARP-AXE>
          <TELL "You consider a random axe of violence, but it would seem a little axe-cessive." CR>
        )
        (<HELD? ,BLUNT-AXE>
          <TELL "You couldn't cut butter with this axe." CR>
        )
        (ELSE
          <TELL "You need a weapon to do that, now where did you leave your axe?" CR>
        )
      >
    )
  >
>

;----------------------------------------------------------------------
;"###################### WOODLAND CLEARING ######################"
;----------------------------------------------------------------------

<OBJECT WOODLAND-CLEARING
  (DESC "Woodland Clearing")
  (IN ROOMS)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH NWOODS)
  (SOUTH NORTH-BANK)
  (ACTION WOODLAND-CLEARING-R)>


<ROUTINE WOODLAND-CLEARING-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
     <MOVE ,DYLAN ,HERE>)>
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL 
"A clearing in the wood, looks like it was once a small holding. There is a carpet of thyme
underfoot that releases a sweet tang into the air as you walk across it.||You can go north or
south." CR>)>>


;----------------------------------------------------------------------
;"###################### NORTH BANK OF THE RIVER VOID ######################"
;----------------------------------------------------------------------

<OBJECT NORTH-BANK
  (DESC "North Bank of the River Void")
  (IN ROOMS)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (NORTH WOODLAND-CLEARING)
  (ACTION NORTH-BANK-R)
  (GLOBAL RIVER-VOID BROKEN-BRIDGE)>


<ROUTINE NORTH-BANK-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
      <MOVE ,DYLAN ,HERE>
    )
    (<==? .RARG ,M-LOOK>
      <TELL 
"You are on the Northbank of the River Void. The river is roaring past with a fierce current.||You
can go north." CR>
    )
    (<AND <==? .RARG ,M-BEG><VERB? SWIM>>
      <TELL "It's far too dangerous to swim across." CR>
      <FUCKING-CLEAR>
    )
  >
>

<OBJECT REEDS
  (SYNONYM REED REEDS)
  (ADJECTIVE THICK BEDS)
  (DESC "reeds")
  (FDESC "On the edge of the riverbank there are thick beds of reeds.")
  (IN NORTH-BANK)
  (FLAGS TAKEBIT PLURALBIT)
  (ACTION REEDS-R)
>

<ROUTINE REEDS-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "They are long and fibrous water reeds." CR>
    )
    (<AND <VERB? TAKE> <NOT <FSET? ,REEDS ,TOUCHBIT>>>
      <TELL "You pick a large bail of reeds." CR>
      <MOVE ,REEDS ,PLAYER>
      <FSET ,REEDS ,TOUCHBIT>
    )
    (<VERB? TIE>
      <TELL "Nice idea, but you lack the skill." CR>
    )
    (< AND <VERB? GIVE><PRSI? ,GNOME-CHOMPSKY>>
      <GIVE-CHOMPSKY-REEDS-R>
    )    
  >
>

<ROUTINE GIVE-CHOMPSKY-REEDS-R ()
  <COND
    (<AND <VERB? GIVE> <PRSI? ,REEDS>>
      <TELL
"\"Ah river reeds, perfect for rope making, let me sort that out for you.\" With his quick and
nimble fingers the Gnome weaves the reeds together with astonishing speed. He hands you a long coil
of strong rope." CR>
      <MOVE ,REEDS <>>
      <MOVE ,ROPE ,PLAYER>
    )
  >
>

;"LOCAL-GLOBALS"

<OBJECT RIVER-VOID
  (SYNONYM RIVER VOID)
  (IN LOCAL-GLOBALS)
  (DESC "River Void")
  (LDESC 
"The River Void is fast, deep and wide. The water level is unusually high and it is roaring loudly
as it flows past. It looks like the bridge across has collapsed.")
  (FLAGS NDESCBIT)
>

<OBJECT BROKEN-BRIDGE
  (IN LOCAL-GLOBALS)
  (SYNONYM BRIDGE)
  (ADJECTIVE BROKEN)
  (DESC "broken bridge")
  (FLAGS NDESCBIT)
  (LDESC 
"A wooden footbridge, which has collapsed in the middle leaving a yawning gap down to the dangerous
river below. What a terrible thing to happen, you can't get over it.")
  (ACTION BROKEN-BRIDGE-R)
>

<ROUTINE BROKEN-BRIDGE-R ()
  <TELL "TODO!" CR>
>

;----------------------------------------------------------------------
;"###################### NOWHERE ######################"
;----------------------------------------------------------------------

;"TODO - PLACEHOLDER"
<OBJECT ROPE
>

;"TODO - PLACEHOLDER"
<OBJECT RAFT
>

;----------------------------------------------------------------------
;"###################### TEXT ROUTINES ######################"
;----------------------------------------------------------------------

<ROUTINE BOLDIZE (TEXT)
  <HLIGHT H-BOLD>
  <TELL .TEXT>
  <HLIGHT 0>>

;----------------------------------------------------------------------
;"###################### SILLINESS ######################"
;----------------------------------------------------------------------
<ROUTINE V-ENJOY ()
	 <TELL "Not difficult at all, considering how enjoyable" T, PRSO " is." CR>>
   
;"OG"
<ROUTINE FUCKING-CLEAR ()
  <SETG P-CONT -1>
  <RFATAL>
>