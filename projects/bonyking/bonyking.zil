"The Bony King of Nowhere - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
  "The Bony King of Nowhere (ZIL Port)|
  An Interactive Adventure by Luke A. Jones|
  Copyright (c) 2017 Luke A. Jones. All rights reserved.">

<ROUTINE GO ()
  <CRLF> <CRLF>
  <TELL "You are a citizen of the land of Nowhere, and you are given an urgent letter to deliver to the King. Navigate your way through the strange and twisted landscape to the capital city of Lost and gain access to the King's castle." CR CR "This is a casual text adventure game in the classic parser style." CR CR "Note: This game was an entry in The 2017 Spring Thing Festival of Interactive Fiction (springthing.net)" CR CR>
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
<INSERT-FILE "parser">

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
  <TELL "You can't " .WORD " " T ,PRSO "." CR>>

<ROUTINE V-PET () <PET-F "pet">>
<ROUTINE V-PAT () <PET-F "pat">>
<ROUTINE V-STROKE () <PET-F "stroke">>

;----------------------------------------------------------------------
;"#################### YOUR HOVEL ####################"
;----------------------------------------------------------------------

<OBJECT HOVEL
    (IN ROOMS)
    (DESC "Your Hovel")
    (FLAGS LIGHTBIT)
    (LDESC "You are in your hovel in the northernmost borderlands of the Kingdom of Nowhere. It is a round wattle and daub hut. There is a fireplace in the middle with a hole in the thatch roof above it acting as a chimney.||Around the circumference of the room there are a few sticks of furniture and rags that represent the totality of your worldly possessions.")
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
        <TELL "An ancient wooden chest that has been repeatedly patched and repaired. You'll be pleased to know there is no lock." CR>)>>

<OBJECT BLUNT-AXE
    (DESC "axe")
    (SYNONYM AXE)
    (IN CHEST)
    (FLAGS TAKEBIT VOWELBIT)
    (ACTION BLUNT-AXE-R)>

<ROUTINE BLUNT-AXE-R ()
  <COND 
    (<VERB? EXAMINE>
      <TELL "An axe with an arms length wooden haft and a steel head with the letter L and the pattern of a rose embossed on it. It is your prized (and only) possession given to you by your father. It's blade is a sharp as Jack after a busy day." CR>)
    (<VERB? SHARPEN>
      <COND
        (<NOT <IN? ,BLUNT-AXE ,PLAYER>>
          <TELL "You don't have that." CR>)
        (<IN? ,PLAYER ,HOVEL>
          <REMOVE ,BLUNT-AXE>
          <MOVE , AXE ,PLAYER>
          <THIS-IS-IT ,AXE>
          <TELL "You walk over to the hearthstones and sharpen the axe blade on one of them. After a minute or so, it gleams with a wicked edge. It is now an axe-is of evil." CR>)
        (T
          <TELL "There is nothing here to sharpen it on." CR>)>)>>

<OBJECT AXE
  (DESC "axe")
  (SYNONYM AXE)
  (FLAGS TAKEBIT VOWELBIT)
  (ACTION AXE-R)>

<ROUTINE AXE-R ()
  <COND 
    (<VERB? EXAMINE>
      <TELL "An axe with an arms length wooden haft and a sharpened steel head with the letter L and the pattern of a rose embossed on it. It is your prized (and only) possession given to you by your father. It's blade is sharp as frost." CR>)
    (<VERB? SHARPEN>
      <TELL "It's already sharp." CRLF>)
    (<VERB? DROP>
      <TELL "You drop the useful looking axe, a wise move I'm sure." CR>
      <MOVE ,AXE ,HERE>)>>

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
      <TELL "A round circle of flat stones with the ashen remains of last night's fire smouldering in the middle.">
      <COND
        (<IN?, SHOVEL, HOVEL>
          <TELL " Leaning against the fireplace is a shovel.">)>
      <CRLF>)
    (<VERB? LIGHT>
      <TELL "You could rekindle the fire but you decide not to as you are low on fuel. Besides, you need to get out and about." CR>)>>

<OBJECT DYLAN
  (IN HOVEL)
  (DESC "your dog")
  (FLAGS NARTICLEBIT NALLBIT PERSONBIT)
  (SYNONYM DYLAN DOG)
  (ACTION DYLAN-R)>
  
<ROUTINE DYLAN-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "It's your faithful canine companion. He's an ageing Boxer mongrel of some sort. He has tan brown fur with a white patch on his chest. He's seen a few too many scrapes and doesn't smell too sweet, but you love him dearly and he's called Dylan." CR>)
    (<VERB? TAKE>
      <TELL "You don't need to carry him. He'll follow you anywhere." CR>)
    (<VERB? HACK ATTACK>
      <TELL "He's your only friend in the world. You'd never hurt him." CR>)
    (<VERB? PET PAT STROKE>
      <TELL "Dylan nuzzles against your leg and looks up to you with doleful eyes, his tail wagging expectantly.">
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
      <TELL "Furniture might be a rather grand term what consists of a filthy straw bed and a battered wooden chest." CR>)>>

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
      <TELL "Several large rectangular bales of hay lashed together. It is blackened with grime and splattered with mud." CR>)
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
      <TELL "The circular roof is made from straw thatch, with a small hole in the centre to let out the smoke from the fire." CR>)>>

<OBJECT HOLE
  (IN HOVEL)
  (DESC "hole")
  (SYNONYM HOLE)
  (FLAGS NDESCBIT)
  (ACTION HOLE-R)>

<ROUTINE HOLE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "A small hole in the centre of the roof. You made it to let out the smoke from the fire." CR>)>>

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

<SYNTAX BOARD OBJECT = V-BOARD>
<VERB-SYNONYM BOARD RIDE MOUNT>

<ROUTINE V-BOARD ()
  <COND
    (<NOT <FSET? ,PRSO ,VEHBIT>>
     <TELL T ,PRSO " can't be boarded." CR>
     <RETURN T>)
    (<==? ,PRSO ,VEHICLE>
     <TELL "You're already on " T ,PRSO "." CR>
     <RETURN T>)
    (<IN? ,PRSO ,PLAYER>
     <TELL "You can't ride something you're already holding." CR>
     <RETURN T>)
    (<NOT <ACCESSIBLE? ,PRSO>>
     <TELL "You can't reach " T ,PRSO "." CR>
     <RETURN T>)
    (T
     <MOVE ,PLAYER ,PRSO>
     <SETG VEHICLE ,PRSO>
     <TELL "Done." CR>
     <V-LOOK>)>>

<SYNTAX EXIT = V-EXIT>
<SYNTAX EXIT OBJECT = V-EXIT>
<VERB-SYNONYM EXIT DEPART WITHDR DISMOUNT>


<ROUTINE V-EXIT ()
     <COND
       (<OR <AND <NOT ,PRSO> <IN? ,PLAYER ,VEHICLE>> <FSET? ,PRSO ,VEHBIT>>
         <MOVE ,PLAYER ,HERE>
          <FCLEAR ,PRSO ,NDESCBIT>
          <TELL "Done." CR CR>
          <V-LOOK>
          <RTRUE>)
      (T
        <DO-WALK ,P?OUT>)>>



;-------------------------------------------------------------------------------
;"NOTE: The horse won't be in the hovel. It's just here now for testing."
;-------------------------------------------------------------------------------
<OBJECT HORSE
  (DESC "horse")
  (IN HOVEL)
  (FLAGS VEHBIT CONTBIT SURFACEBIT SEARCHBIT OPENBIT)
  (SYNONYM HORSE)
  (ACTION HORSE-R)>

<GLOBAL VEHICLE <>>


<ROUTINE HORSE-R (RARG)
  <COND 
  (<VERB? EXAMINE>
        <TELL "A perfectly ordinary horse." CR>)>>

;----------------------------------------------------------------------
;"###################### NORTHERN MEADOW ######################"
;----------------------------------------------------------------------

<OBJECT NMEADOW
  (DESC "Northern Meadow")
  (IN ROOMS)
  (FLAGS LIGHTBIT OUTSIDEBIT)
  (IN PER ENTER-HOVEL-R)
  (ACTION NMEADOW-R)>

<ROUTINE NMEADOW-R (RARG)
  <COND
    (<==? .RARG ,M-ENTER>
     <MOVE ,DYLAN ,HERE>)>
  <COND
    (<==? .RARG ,M-LOOK>
      <TELL "You are in the meadow outside your hovel, several acres of wild grassland and wild flowers. You may be dirt poor, but the beauty of the landscape is some consolation." CR>
      <COND
        (<NOT <FSET? ,HERE ,TOUCHBIT>>
          <TELL CR "As you step out of your home there is a beating of wings above your head. Looking up, you see a pigeon rapidly disappearing out of sight, and a letter flutters to your feet. You pick it up." CR CR "On the wind, you can hear a distant shout of what sounds like, \"fuck yooouuuu...\" coming from the pigeon's direction before it disappears from sight." CR>
          <MOVE ,LETTER ,PLAYER>)>)>>

<ROUTINE ENTER-HOVEL-R ()
  <COND
    (<IN? ,PLAYER ,VEHICLE>
      <TELL "You can't enter while on horseback." CR CR>
      <SETG P-CONT 0>
      <RETURN ,HERE>)
    (T
      <RETURN ,HOVEL>)>>

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
      <TELL "You're dying to know what's in the letter, but the instructions written on it forbid you from doing so. You can examine it." CR>)
    (<VERB? EXAMINE>
      <TELL "The letter is addressed to the Bony King of Nowhere, at his palace in the capital Lost, many miles to the south. On the reverse is written:|\"">
      <ITALICIZE "If found please deliver personally to the King, the contents are confidential and you are forbidden from reading them. Failure to comply with either of these requests will result in summary execution.">
      <TELL "\"||Well that's just perfect you think, you've always hated a) the capital, b) the monarchy, and c) the south in general." CR>)
    (<VERB? OPEN>
      <TELL "You can't open it, the King will have you killed!" CR>)
    (<VERB? CLOSE>
      <TELL "It's already closed.">)
    (<VERB? HACK>
      <COND
        (<HELD? AXE>
          <TELL "You consider chopping the letter into pieces, but the King has spies everywhere and you value your life." CR>)
        (<HELD? BLUNT-AXE>
          <TELL "Your axe is too blunt (and it's probably not a good idea)." CR>)
        (T
          <TELL "You need a tool for that." CR>)>)>>

;----------------------------------------------------------------------
;"###################### DIRTY HACKS ######################"
;----------------------------------------------------------------------
<ROUTINE DESCRIBE-ROOM (RM "OPT" LONG "AUX" P)
    <COND (<AND <==? .RM ,HERE> <NOT ,HERE-LIT>>
           <DARKNESS-F ,M-LOOK>
           <RFALSE>)>
    ;"Print the room's real name."
    <VERSION? (ZIP) (ELSE <HLIGHT ,H-BOLD>)>
    <TELL D .RM>
    <COND
      (<IN? ,PLAYER ,VEHICLE>
        <COND
          (<FSET? ,VEHICLE ,SURFACEBIT>
            <TELL " (on " T, VEHICLE ")" >)
          (T
            <TELL " (in " T, VEHICLE ")" >)>)>
    <CRLF>
    <VERSION? (ZIP) (ELSE <HLIGHT ,H-NORMAL>)>
    ;"If this is an implicit LOOK, check briefness."
    <COND (<NOT .LONG>
           <COND (<EQUAL? ,MODE ,SUPERBRIEF>
                  <RFALSE>)
                 (<AND <FSET? .RM ,TOUCHBIT>
                       <NOT <EQUAL? ,MODE ,VERBOSE>>>
                  ;"Call the room's ACTION with M-FLASH even in brief mode."
                  <APPLY <GETP .RM ,P?ACTION> ,M-FLASH>
                  <RTRUE>)>)>
    ;"The room's ACTION can print a description with M-LOOK.
      Otherwise, print the LDESC if present."
    <COND (<APPLY <GETP .RM ,P?ACTION> ,M-LOOK>)
          (<SET P <GETP .RM ,P?LDESC>>
           <TELL .P CR>)>
    ;"Call the room's ACTION again with M-FLASH for important descriptions."
    <APPLY <GETP .RM ,P?ACTION> ,M-FLASH>
    ;"Mark the room visited."
    <FSET .RM ,TOUCHBIT>
    <RTRUE>>


<ROUTINE V-WALK ("AUX" PT PTS RM D)
    <COND (<NOT ,PRSO-DIR>
           <PRINTR "You must give a direction to walk in.">)
          (<0? <SET PT <GETPT ,HERE ,PRSO>>>
           <COND (<OR ,HERE-LIT <NOT <DARKNESS-F ,M-DARK-CANT-GO>>>
                  <TELL ,CANT-GO-THAT-WAY CR>)>
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
    <COND
      (<IN? ,PLAYER ,VEHICLE>
        <MOVE ,VEHICLE .RM>
        <SET HERE .RM>
        <DESCRIBE-ROOM .RM>)
      (T
        <GOTO .RM>)>>


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