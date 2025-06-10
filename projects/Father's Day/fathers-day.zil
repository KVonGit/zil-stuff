"Father's Day - MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
"Father's Day
|An Interactive Tale of Terror
|By KV"
>

<ROUTINE GO ()
  <SETG MODE ,VERBOSE>
  <SETG HERE ,CEMETERY>
  <MOVE ,PLAYER ,HERE>
  <CRLF>
  <CRLF>
  <ITALICIZE "You visit your dad every Father's Day...">
  <CRLF>
  <CRLF>
  <V-VERSION>
  <CRLF>
  <V-LOOK>
  <QUEUE I-COULDNT-GO -1>
  <MAIN-LOOP>
>
  
;"----------------------- UNCOMMENT TO ENABLE DEBUGGING COMMANDS ----------------------------------"
;"<COMPILATION-FLAG DEBUGGING-VERBS T>"

;"----------------------- UNCOMMENT TO ADD FLAGS --------------------------------------------------"
<SETG EXTRA-FLAGS (VEHBIT NALLBIT)>


<INSERT-FILE "parser">

;"------------------------- UNCOMMENT TO REDEFINE STUFF -------------------------------------------"
<SET REDEFINE T>


;"==================================== GAME WORLD ================================================="


;"************************************* OUTSIDE ***************************************************"

<ROOM CEMETERY
    (DESC "Cemetery")
    (IN ROOMS)
    (LDESC "Your family cemetery has seen better days, but no one here ever complains.||The front
yard is to the northeast, and the woods mostly surround you (to the east, west, and northeast).")
    (EAST TO WOODS-TWO)
    (WEST TO WOODS)
    (NORTHEAST TO WOODS-THREE)
    (NORTHWEST TO FRONT-YARD)
    (FLAGS LIGHTBIT)
    (ACTION CEMETERY-R)
>

<ROUTINE CEMETERY-R (RARG)
  <COND
    (<==? .RARG ,M-BEG>
      <COND
        (<AND <VERB? WALK> <==? ,ZOMBIE-HAND-GOT-YA 1>>
          <TELL "You can't go anywhere! The hand is holding onto you and you can't walk!!!" CR>
          <SETG P-CONT -1>
          <RFATAL>)
      >)
  >
>


<OBJECT FRESHLY-DUG-GRAVE
    (IN CEMETERY)
    (DESC "freshly dug grave")
    (FDESC "There is a fresh grave here.")
    (LDESC "Not much to it, besides the headstone.")
    (SYNONYM GRAVE)
    (ADJECTIVE FRESHLY DUG NEW)
    (FLAGS NARTICLEBIT)
>

<OBJECT HEADSTONE
  (IN CEMETERY)
  (DESC "headstone")
  (TEXT "IF YOU CAN READ THIS, THE GAME IS BROKEN.")
  (SYNONYM TOMBSTONE HEADSTONE STONE HEADST WRITIN WRITING WORDS)
  (ADJECTIVE HEAD)
  (FLAGS READBIT NDESCBIT)
  (ACTION HEADSTONE-R)
>


<OBJECT ZOMBIE-HAND
  (IN FRESHLY-DUG-GRAVE)
  (DESC "zombie hand")
  (SYNONYM HAND)
  (ADJECTIVE ZOMBIE)
  (ACTION ZOMBIE-HAND-R)
  (FLAGS NDESCBIT NALLBIT)
>


<GLOBAL ZOMBIE-BITE-COUNTDOWN 4>
<GLOBAL ZOMBIE-EXITS <>>
<GLOBAL ZOMBIE-HAND-GOT-YA <>>
<GLOBAL ONCE-BITTEN <>>
<GLOBAL TWICE-SHY <>> ;"unused"

<ROUTINE HEADSTONE-R ()
  <COND
    (<VERB? READ>
      <COND
        (<==? <LOC ,ZOMBIE-HAND> ,FRESHLY-DUG-GRAVE>
          <TELL
"Just as you bend down to read it, a ZOMBIE HAND bursts out of the ground and grabs you!!!" CR>
          <MOVE ,ZOMBIE-HAND ,HERE>
          <THIS-IS-IT ,ZOMBIE-HAND>
          <SETG ZOMBIE-HAND-GOT-YA 1>
          <QUEUE I-ZOMBIE-HAND -1>
        )
        (T
          <TELL
"There's no time for reading that right now!" CR>
          <RTRUE>)
      >
    )
    (<VERB? EXAMINE>
      <TELL 
"The writing on it is so small, you may not be able to read it." CR>
    )
  >
>
          
<ROUTINE ZOMBIE-EMERGES-R ()
  <TELL 
"||A hideous ZOMBIE crawls out of the grave!" CR>
  <MOVE ,ZOMBIE ,HERE>
  <QUEUE I-ZOMBIE -1>
>


<ROUTINE I-ZOMBIE ()
  <COND
    (<==? <LOC ,ZOMBIE> ,HERE>
      <SETG ZOMBIE-SHADOW 1>
      <SETG ZOMBIE-BITE-COUNTDOWN <- ,ZOMBIE-BITE-COUNTDOWN 1>>
      <COND
        (<G? ,ZOMBIE-BITE-COUNTDOWN 1>
          <TELL
"||The zombie slowly limps towards you..." CR>)
        (<==? ,ZOMBIE-BITE-COUNTDOWN 1>
          <TELL
"||The zombie is VERY close!!!" CR>)
        (T
          <ZOMBIE-BITE-R>)>)
    (T
      <COND
        (<==? ,ZOMBIE-SHADOW 1>
          <MOVE ,ZOMBIE <LOC ,PLAYER>>
          <TELL "||The zombie follows closely." CR>
        )
        (ELSE
          <TEST-ZOMBIE-EXITS <LOC ,ZOMBIE>>
        )
      >
    )
  >
>

;"Thanks to the ChatGPT Zil setup and Adam Sommerfield for setting it up!"
<ROUTINE TEST-ZOMBIE-EXITS (ZLOC "AUX" TABLE IDX CHOSEN DEST)
  <SET TABLE <ITABLE 10>>
  <SET IDX 0>
  <MAP-DIRECTIONS (D P .ZLOC)
    <PUTB .TABLE .IDX <GET .P ,REXIT>>
    <SET IDX <+ .IDX 1>>
  >
  <COND
    (<0? .IDX>
      ;<TELL "No exits for the ZOMBIE!" CR>
    )
    (T
     <SET CHOSEN <RANDOM .IDX>>
     <SET DEST <GETB .TABLE .CHOSEN>>
     ;<TELL "The ZOMBIE randomly moves to " D .DEST "." CR>
     ;"TODO - Make REVERSE-DIRECTION routine to say The ZOMBIE enters from the DIR."
     <MOVE ,ZOMBIE .DEST>
     <COND
      (<==? .DEST ,HERE>
        <TELL "||A ZOMBIE suddenly appears!!!" CR>
      )
      >
    )
  >
>

<ROUTINE ZOMBIE-BITE-R ()
  <COND
    (<NOT <==? ,ONCE-BITTEN 1>>
      <SETG ONCE-BITTEN 1>
      <TELL "||The zombie BITES you!!!" CR>
    )
    (T
      <TELL "||The zombie stands silently beside you, mumbling and groaning." CR>
    )
  >
>


<ROUTINE ZOMBIE-HAND-R ()
  <COND
    (<VERB? ATTACK>
      <COND
        (<==? ,ZOMBIE-HAND-GOT-YA 1>
          <SETG ZOMBIE-HAND-GOT-YA <>>
          <TELL 
"After a brief struggle with the zombie hand, you eventually manage to get it off of you." CR>)
        (T
          ;"TODO - Create a stooges-style routine for this!"
          <TELL "Attacking the hand has no obvious effect. It just flops back and forth." CR>)>)
    (<VERB? EXAMINE>
      <TELL "It looks just like every other zombie hand you've ever seen." CR>)
    (<VERB? SPEAK>
      <TELL "The zombie hand snaps back at you." CR>)
    (<VERB? TAKE>
      <COND
        (<==? ,ZOMBIE-HAND-GOT-YA 1>
          <TELL "You have lost your mind. It's got a hold of YOU, not the other way around!" CR>)
        (<HELD? ,ZOMBIE-HAND>
          <TELL
"The zombie hand taps you on your shoulder, as if to say, \"hello! I'm here already!\"" CR>)
        (T
          <COND
            (<NOT <FSET? ,ZOMBIE-HAND ,TOUCHBIT>>
              <FSET ,ZOMBIE-HAND ,TOUCHBIT>
              <TELL
"You get a good, firm grip on the hand, and it breaks off at the wrist. It quickly runs up your arm
and perches, palm-down, upon your shoulder." CR>
              <MOVE ,ZOMBIE-HAND ,PLAYER>
              ;"TODO - CREATE ZOMBIE-ARM and HOLE-IN-GRAVE and MOVE HERE!")
            (T
              <TELL 
"After thumb-wrestling with the stupid hand for half a turn, you finally manage to pick it up. It
lets its fingers do the walking up your arm and perches, palm-down, upon your shoulder." CR>
          <MOVE ,ZOMBIE-HAND ,PLAYER>)>)>)>>

<ROUTINE I-ZOMBIE-HAND ()
  <COND
    (<AND <IN? ,ZOMBIE-HAND ,PLAYER> <NOT <==? ,PRSO ,ZOMBIE-HAND>>>
      <COND
        (<VERB? WAIT>
          <TELL CR "The zombie hand taps its fingers impatiently." CR>
        )
        (<==? ,COULDNT-GO 1>
          <TELL CR 
"The zombie hand pats your shoulder, as if to say, \"that's okay, Adventurer! You'll learn to walk
one day soon!\"" CR>
          ;"<SETG COULDNT-GO 0>")
        (ELSE
          <TELL CR "The zombie hand rests happily on your shoulder." CR>
        )
      >
    )
    (<AND <==? <LOC ,ZOMBIE-HAND> ,HERE> <NOT <PRSO? ,ZOMBIE-HAND>>>
      <COND
        (<==? ,ZOMBIE-HAND-GOT-YA 1>
          <TELL CR "The zombie hand has a firm grip on you!" CR>)
        (T
          <COND
            (<FSET? ,ZOMBIE-HAND ,TOUCHBIT>
              <TELL "The zombie hand flops around helplessly." CR>)
            (T
              <TELL CR "The zombie hand flails around aimlessly." CR>)
          >)
      >
    )
  >
>

<GLOBAL ZOMBIE-SHADOW <>>

<OBJECT ZOMBIE
  (IN FRESHLY-DUG-GRAVE)
  (DESC "the zombie")
  (SYNONYM ZOMBIE)
  (FLAGS PERSONBIT NARTICLEBIT NDESCBIT)
  (ACTION ZOMBIE-R)
>
  
<ROUTINE ZOMBIE-R (RARG)
  <COND
    (<AND <==? .RARG ,M-END> <VERB? WALK> <==? <LOC ,ZOMBIE> ,HERE> <==? ,ZOMBIE-SHADOW 1>>
      <TELL "The zombie follows you." CR>
    )
  >    
>

<ROOM FRONT-PORCH
    (DESC "Front Porch")
    (LDESC "You can go south to the front yard, or in to the living room.")
    (IN ROOMS)
    (SOUTH TO FRONT-YARD)
    (FLAGS LIGHTBIT)
    (GLOBAL FRONT-DOOR)
    (IN TO LIVING-ROOM IF FRONT-DOOR IS OPEN)
>

<OBJECT FRONT-DOOR
    (IN LOCAL-GLOBALS)
    (DESC "front door")
    (SYNONYM DOOR)
    (ADJECTIVE FRONT)
    (FLAGS OPENABLEBIT DOORBIT OPENBIT)
>

;"********************************* INSIDE THE HOUSE **********************************************"
<ROOM LIVING-ROOM
    (DESC "Living Room")
    (LDESC "You can go out to the front porch.")
    (IN ROOMS)
    (OUT TO FRONT-PORCH IF FRONT-DOOR IS OPEN)
    (WEST TO KITCHEN)
    (FLAGS LIGHTBIT)
    (GLOBAL FRONT-DOOR)
>

<ROOM KITCHEN
  (DESC "Kitchen")
  (LDESC "Your dad's kitchen is even smaller than yours.||You can go east to the
living room or north to the dining room.")
  (IN ROOMS)
  (EAST TO LIVING-ROOM)
  (NORTH TO DINING-ROOM)
  (FLAGS LIGHTBIT)
>

<OBJECT FRIDGE
  (SYNONYM FRIDGE REFRIG REFRIGERATOR ICEBOX)
  (DESC "fridge")
  (IN KITCHEN)
  (LDESC "The old refrigerator hums in the corner.")
  (FLAGS CONTBIT OPENABLEBIT)
>

<OBJECT BEER
  (IN FRIDGE)
  (SYNONYM CAN SQUIFFY BEER)
  (ADJECTIVE CAN SQUIFFY COLD)
  (DESC "can of Squiffy beer")
  (FLAGS TAKEBIT OPENABLEBIT)
  (ACTION BEER-R)
>

<ROUTINE BEER-R ()
  <COND
    (<VERB? LOOK>
      <TELL "A">
      <COND
        (<FSET? ,PRSO ,OPENBIT>
          <TELL "n open">)
        (ELSE
          <TELL " closed">)>
      <TELL " can of Squiffy beer." CR>
    )
    (<VERB? DRINK>
      <TELL "You don't look old enough." CR>
    )
    (<AND <VERB? TAKE> <NOT <FSET? ,BEER ,TOUCHBIT>>>
      <TELL "As you take the beer, you hear a strange sound from outside. (Probably unrelated.)">
      <COND
        (<==? <LOC ,ZOMBIE-HAND> ,PLAYER>
          <TELL " The zombie hand squeezes your shoulder.">
        )
      >
      <CRLF>
      <MOVE ,BEER ,PLAYER>
      <MOVE ,ZOMBIE ,CEMETERY>
      <QUEUE I-ZOMBIE -1>
      <FSET ,BEER ,TOUCHBIT>
    )
  >
>

<ROOM DINING-ROOM
  (IN ROOMS)
  (DESC "Dining Room")
  (SOUTH TO KITCHEN)
  (FLAGS LIGHTBIT)
>

<OBJECT TABLE
  (IN DINING-ROOM)
  (DESC "table")
  (LDESC "The dining room table takes up the majority of the room.")
  (SYNONYM TABLE)
  (ADJECTIVE DINING ROOM)
  (FLAGS SURFACEBIT CONTBIT OPENBIT)
  (ACTION TABLE-R)
>

<ROUTINE TABLE-R (RARG)
  <COND
    (<VERB? CLIMB>
      <TELL "It wouldn't be able to support you." CR>
    )
  >
>

<OBJECT MANUAL
  (IN TABLE)
  (DESC "game manual")
  (FLAGS TAKEBIT READBIT OPENABLEBIT)
  (SYNONYM MANUAL GUIDE BOOK)
  (ADJECTIVE GAME)
  (ACTION MANUAL-R)
>


<ROUTINE MANUAL-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "It's the manual that I ">
      <ITALICIZE "know ">
      <TELL "you read before you started this game." CR>
    )
    (<VERB? READ>
      <COND
        (<FSET? ,MANUAL ,OPENBIT>
          <TELL "It's too late to try to read it now, Watson. The game is on!">)
        (ELSE
          <TELL "It isn't open, and there's only a picture of a rotten hand on the cover." CR>
        )
      >
    )
  >
>

<ROOM WOODS
    (DESC "Woods")
    (LDESC "The woods are lovely, dark, and deep. You can go north, west, or east.")
    (IN ROOMS)
    (NORTH TO FRONT-YARD)
    (EAST TO CEMETERY)
    (WEST TO WOODS-FOUR)
    (FLAGS LIGHTBIT)
>


<ROOM WOODS-TWO
    (DESC "Woods")
    (LDESC "The woods are dark, deep, and lovely. You can go north or west.")
    (IN ROOMS)
    (NORTH TO WOODS-THREE)
    (WEST TO CEMETERY)
    (FLAGS LIGHTBIT)
>


<ROOM FRONT-YARD
    (DESC "Front Yard")
    (LDESC "You can go north to the porch, west to driveway, southeast to the
cemetery, or any other direction into the woods.")
    (IN ROOMS)
    (NORTH TO FRONT-PORCH)
    (SOUTH TO WOODS)
    (EAST TO WOODS-THREE)
    (WEST TO DRIVEWAY)
    (SOUTHEAST TO CEMETERY)
    (SOUTHWEST TO WOODS-FOUR)
    (FLAGS LIGHTBIT)
>


<ROOM DRIVEWAY
    (DESC "Driveway")
    (LDESC "You can go west to the highway, east to the front yard, or south towards the woods.")
    (IN ROOMS)
    (SOUTH TO WOODS-FOUR)
    (EAST TO FRONT-YARD)
    (WEST TO HIGHWAY)
    (FLAGS LIGHTBIT)
>

<OBJECT ZIL
    (IN DRIVEWAY)
    (DESC "Zil")
    (LDESC "The old Zil is parked here.")
    (SYNONYM ZIL)
    (FLAGS CONTBIT OPENABLEBIT LOCKEDBIT VEHBIT)
    (ACTION ZIL-R)
>

<ROUTINE ZIL-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL
"It's your father's 1977 ZIL-114, with a 6,959 cc V8 engine, the three-speed automatic transmission,
and a big bumper sticker that reads 'VEHBIT.' He had it imported from Russia back in the nineties,
but the VEHBIT kit was added recently." CR>)
    (<VERB? TAKE>
      <TELL "Yeah right!" CR>)>>

<ROOM WOODS-THREE
    (DESC "Woods")
    (LDESC "The woods are lovely, deep, and dark. You can go south, west, or southwest.")
    (IN ROOMS)
    (SOUTH TO WOODS-TWO)
    (WEST TO FRONT-YARD)
    (SOUTHWEST TO CEMETERY)
    (FLAGS LIGHTBIT)
>

<ROOM WOODS-FOUR
    (DESC "Woods")
    (LDESC "The woods are lovely, dark, and deep. You can go north, east, or northeast.")
    (IN ROOMS)
    (NORTH TO DRIVEWAY)
    (EAST TO WOODS)
    (NORTHEAST TO FRONT-YARD)
    (FLAGS LIGHTBIT)
>

<ROOM HIGHWAY
    (DESC "Highway")
    (LDESC "You can go east towards the driveway. (The road is under construction.)")
    (IN ROOMS)
    (EAST TO DRIVEWAY)
    (FLAGS LIGHTBIT)
>

;"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
<ROOM CABIN
  (DESC "Cabin")
  (IN ROOMS)
>

;"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
<ROOM SHED
  (DESC "Shed")
  (IN ROOMS)
>

;"#################################### CLOTHES AND SUCH ###########################################"

;"TODO - Make CONTBIT and add appropriate code to handle things "
<OBJECT PANTS
  (IN PLAYER)
  (SYNONYM PANTS)
  (ADJECTIVE MY PAIR)
  (DESC "your pants")
  (FLAGS WEARBIT WORNBIT NARTICLEBIT TAKEBIT)
>

<OBJECT PANTS-POCKET
  (IN GLOBAL-OBJECTS)
  (SYNONYM PANTS POCKET)
  (DESC "pants pocket")
  (FLAGS CONTBIT OPENBIT)
>

;"------------------------------------- NEW COMMANDS ----------------------------------------------"

<SYNTAX SPEAK TO OBJECT = V-SPEAK>
<SYNTAX SPEAK WITH OBJECT = V-SPEAK>

<VERB-SYNONYM SPEAK TALK>

<ROUTINE V-SPEAK ()
  <COND
    (<OR <FSET? ,PRSO ,PERSONBIT> <FSET? ,PRSO ,FEMALEBIT>>
      <TELL D, PRSO " does not reply." CR>
    )
    (T
      <POINTLESS "Trying to speak with" >
    )
  >
>

;"//////////////////////////////////// HACKS BEGIN \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"

;" Hacked to list contents of PANTS-POCKET in GLOBAL-OBJECTS "

<ROUTINE V-INVENTORY ()
  ;"check for light first"
  <COND
    (,HERE-LIT
      <COND 
        (<FIRST? ,WINNER>
          <TELL "You have:" CR>
          <MAP-CONTENTS (I ,WINNER)
            <TELL "   " A .I>
            <AND <FSET? .I ,WORNBIT> <TELL " (worn)">>
            <COND
              (<==? .I ,PANTS>
                <COND
                  (<FIRST? ,PANTS-POCKET>
                    <TELL CR "   In your pants pockets:" CR>
                    <MAP-CONTENTS (J ,PANTS-POCKET)
                      <TELL "      " A .J>
                    >
                  )
                >
              )
            >
            <AND <FSET? .I ,LIGHTBIT> <TELL " (providing light)">>
            <COND
              (<FSET? .I ,CONTBIT>
                <COND 
                  (<FSET? .I ,OPENABLEBIT>
                    <COND 
                      (<FSET? .I ,OPENBIT>
                        <TELL " (open)">
                      )
                      (ELSE
                        <TELL " (closed)">
                      )
                    >
                  )
                >
                <COND
                  (<SEE-INSIDE? .I>
                    <INV-DESCRIBE-CONTENTS .I>
                  )
                >
              )
            >
            <CRLF>
          >
        )
        (ELSE
          <TELL "You are empty-handed." CR>
        )
      >
    )
    (ELSE
      <TELL "It's too dark to see what you're carrying." CR>
    )
  >
>

;" NEW "
<GLOBAL COULDNT-GO 0>

;" NEW "
<ROUTINE I-COULDNT-GO (RARG)
  <QUEUE I-RESET-COULDNT-GO 1>
>

;" NEW "
<ROUTINE I-RESET-COULDNT-GO ()
  <SETG COULDNT-GO 0>
>

;" Hacked to set COULDNT-GO to 1 if unsuccessful. "
<ROUTINE V-WALK ("AUX" PT PTS RM D)
  <COND
    (<NOT ,PRSO-DIR>
      <PRINTR "You must give a direction to walk in.">
    )
    (<0? <SET PT <GETPT ,HERE ,PRSO>>>
      <COND
        (<OR ,HERE-LIT <NOT <DARKNESS-F ,M-DARK-CANT-GO>>>
          <TELL ,CANT-GO-THAT-WAY CR>
          <SETG COULDNT-GO 1>
          <SETG MOVES <- ,MOVES 1>>
        )
      >
      <SETG P-CONT 0>
      <RTRUE>
    )
    (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
      <SET RM <GET/B .PT ,EXIT-RM>>
    )
    (<==? .PTS ,NEXIT>
      <TELL <GET .PT ,NEXIT-MSG> CR>
      <SETG P-CONT 0>
      <RTRUE>
    )
    (<==? .PTS ,FEXIT>
      <COND
        (<0? <SET RM <APPLY <GET .PT ,FEXIT-RTN>>>>
          <SETG P-CONT 0>
          <RTRUE>
        )
      >
    )
    (<==? .PTS ,CEXIT>
      <COND
        (<VALUE <GETB .PT ,CEXIT-VAR>>
          <SET RM <GET/B .PT ,EXIT-RM>>
        )
        (ELSE
          <COND 
            (<SET RM <GET .PT ,CEXIT-MSG>>
              <TELL .RM CR>
            )
            (<AND <NOT ,HERE-LIT> <DARKNESS-F ,M-DARK-CANT-GO>>
              ;"DARKNESS-F printed a message"
            )
            (ELSE
              <TELL ,CANT-GO-THAT-WAY CR>
            )
          >
          <SETG P-CONT 0>
          <SETG COULDNT-GO 1>
          <SETG MOVES <- ,MOVES 1>>
          <RTRUE>
        )
      >
    )
    (<==? .PTS ,DEXIT>
      <COND (<FSET? <SET D <GET/B .PT ,DEXIT-OBJ>> ,OPENBIT>
        <SET RM <GET/B .PT ,EXIT-RM>>
      )
      (<SET RM <GET .PT ,DEXIT-MSG>>
        <TELL .RM CR>
        <SETG P-CONT 0>
        <RTRUE>
      )
      (ELSE
        <THIS-IS-IT .D>
        <TELL "You'll have to open " T .D  " first." CR>
          <SETG P-CONT 0>
          <SETG COULDNT-GO 1>
          <SETG MOVES <- ,MOVES 1>>
          <RTRUE>
        )
      >
    )
    (ELSE
      <TELL "Broken exit (" N .PTS ")." CR>
      <SETG P-CONT 0>
      <SETG COULDNT-GO 1>
      <SETG MOVES <- ,MOVES 1>>
      <RTRUE>
    )
  >
  <GOTO .RM>
>

;" Hacked to exclude objects with NALLBIT flag, and to fix bug(?) where it tries to take..."
;"  ...something from inventory if there is nothing HERE, and it tries to drop something HERE if..."
;"  ...there is nothing held."

<ROUTINE ALL-INCLUDES? (OBJ)
  <NOT
    <OR
      <FSET? .OBJ ,INVISIBLE>
      <FSET? .OBJ ,NALLBIT>
      <=? .OBJ ,WINNER>
      <AND
        <VERB? TAKE>
        <==? <LOC .OBJ> ,WINNER>
      >
      <AND
        <VERB? DROP>
        <NOT
          <==? <LOC .OBJ> ,WINNER>
        >
      >
      <AND
        <VERB? TAKE DROP>
        <NOT
          <AND
            <OR
              <FSET? .OBJ ,TAKEBIT>
              <FSET? .OBJ ,TRYTAKEBIT>
            >
          >
        >
      >
    >
  >
>

;" Hacked to change the response when there is NO ALL TO TAKE/DROP "

<ROUTINE MATCH-NOUN-PHRASE (NP OUT BITS "AUX" F NY NN SPEC MODE NOUT OBITS ONOUT BEST Q)
  <SET NY <NP-YCNT .NP>>
  <SET NN <NP-NCNT .NP>>
  <SET MODE <NP-MODE .NP>>
  <SET OBITS .BITS>
  <COND 
    (<0? .MODE>
      <SET .BITS <ORB .BITS ;"<ORB" ,SF-HELD ,SF-CARRIED ,SF-ON-GROUND ,SF-IN-ROOM ;">" >>
    )
  >
<  TRACE 3 "[MATCH-NOUN-PHRASE: NY=" N .NY " NN=" N .NN " MODE=" N .MODE
         " BITS=" N .BITS " OBITS=" N .OBITS "]" CR>
  <TRACE-IN>
  <PROG BITS-SET ()
    ;"Look for matching objects"
    <SET NOUT 0>
    <COND
      (<0? .NY>
        ;"ALL with no YSPECs matches all objects, or if the action is TAKE/DROP,
          all objects with TAKEBIT/TRYTAKEBIT, skipping generic/global objects."
        <TRACE 4 "[applying ALL rules]" CR>
        <MAP-SCOPE (I [BITS .BITS])
          <COND
            (<SCOPE-STAGE? GENERIC GLOBALS>
            )
            (<NOT <ALL-INCLUDES? .I>>
            )
            (<AND .NN <NP-EXCLUDES? .NP .I>>
            )
            (<G=? .NOUT ,P-MAX-OBJECTS>
              <TELL "[too many objects!]" CR>
              <TRACE-OUT>
              <RETURN>
            )
            (ELSE
              <SET NOUT <+ .NOUT 1>>
              <PUT/B .OUT .NOUT .I>
            )
          >
        >
      )
      (ELSE
        ;"Go through all YSPECs and find matching objects for each one.
          Give an error if any YSPEC has no matches, but it's OK if all
          the matches for some YSPEC are excluded by NSPECs. Keep track of
          the match quality and only select the best matches."
        <DO (J 1 .NY)
          <SET SPEC <NP-YSPEC .NP .J>>
          <TRACE 4 "[SPEC=" OBJSPEC .SPEC "]" CR>
          <SET F <>>
          <SET ONOUT .NOUT>
          <SET BEST 1>
          <MAP-SCOPE (I [BITS .BITS])
             <TRACE 5 "[considering " T .I "]" CR>
             <COND 
               (<AND <NOT <FSET? .I ,INVISIBLE>>
                  <SET Q <REFERS? .SPEC .I>>
                  <G=? .Q .BEST>>
                  <TRACE 4 "[matches " T .I "(" N .I "), Q=" N .Q "]" CR>
                  <SET F T>
                  ;"Erase previous matches if this is better"
                  <COND 
                    (<G? .Q .BEST>
                      <TRACE 4 "[clearing match list]" CR>
                      <SET NOUT .ONOUT>
                      <SET .BEST .Q>
                    )
                  >
                  <COND 
                    (<AND .NN <NP-EXCLUDES? .NP .I>>
                      <TRACE 4 "[excluded]" CR>
                    )
                    (<G=? .NOUT ,P-MAX-OBJECTS>
                      <TELL "[too many objects!]" CR>
                      <TRACE-OUT>
                      <RETURN>
                    )
                    (ELSE
                      <TRACE 4 "[accepted]" CR>
                      <SET NOUT <+ .NOUT 1>>
                      <PUT/B .OUT .NOUT .I>
                    )
                  >
                )
              >
            >
            ;"Look for a pseudo-object if we didn't find a real one."
            <COND
              (<AND <NOT .F>
                <BTST .BITS ,SF-ON-GROUND>
                <SET Q <GETP ,HERE ,P?THINGS>>>
                <TRACE 4 "[looking for pseudo]" CR>
                <SET F <MATCH-PSEUDO .SPEC .Q>>
                <COND
                  (.F
                    <COND
                      (<AND .NN <NP-EXCLUDES-PSEUDO? .NP .F>>
                      )
                      (<G=? .NOUT ,P-MAX-OBJECTS>
                        <TELL "[too many objects!]" CR>
                        <TRACE-OUT>
                        <RETURN>
                      )
                      (ELSE
                        <SET NOUT <+ .NOUT 1>>
                        <PUT/B .OUT .NOUT <MAKE-PSEUDO .F>>
                      )
                    >
                  )
                >
              )
            >
            <COND 
              (<NOT .F>
                ;"Try expanding the search if we can."
                <COND
                  (<N=? .BITS -1>
                    <TRACE 4 "[expanding to ludicrous scope]" CR>
                    <SET BITS -1>
                    <SET OBITS -1>    ;"Avoid bouncing between <1 and >1 matches"
                    <AGAIN .BITS-SET>
                  )
                >
                <COND
                  (<=? ,MAP-SCOPE-STATUS ,MS-NO-LIGHT>
                    <TELL "It's too dark to see anything here." CR>
                  )
                  (ELSE
                    <TELL "You don't see that here." CR>
                  )
                >
                <TRACE-OUT>
                <RFALSE>
              )
              (<G=? .NOUT ,P-MAX-OBJECTS>
                <TRACE-OUT>
                <RETURN>
              )
            >
          >
        )
      >
    ;"Check the number of objects"
    <PUTB .OUT 0 .NOUT>
    <COND
      (<0? .NOUT>
        ;"This means ALL matched nothing, or BUT excluded everything.
          Try expanding the search if we can."
        <SET F <ORB .BITS ;"<ORB" ,SF-HELD ,SF-CARRIED ,SF-ON-GROUND ,SF-IN-ROOM ;">" >>
        <COND
          (<=? .BITS .F>
            <TELL "There is no 'all' available">
            <COND
              (<VERB? TAKE>
                <TELL " to take">
              )
            >
            <COND
              (<VERB? DROP>
                <TELL " to drop">
              )
            >
            <TELL "!" CR>
            <TRACE-OUT>
            <RFALSE>
          )
        >
        <TRACE 4 "[expanding to reasonable scope]" CR>
        <SET BITS .F>
        <SET OBITS .F>    ;"Avoid bouncing between <1 and >1 matches"
        <AGAIN .BITS-SET>
      )
      (<1? .NOUT>
        <TRACE-OUT>
        <RETURN <GET/B .OUT 1>>
      )
      (<OR <=? .MODE ,MCM-ALL> <G? .NY 1>>
        <TRACE-OUT>
        <RETURN ,MANY-OBJECTS>
      )
      (<=? .MODE ,MCM-ANY>
        ;"Pick a random object"
        <PUT/B .OUT 1 <SET F <GET/B .OUT <RANDOM .NOUT>>>>
        <PUTB .OUT 0 1>
        <TELL "[" T .F "]" CR>
        <TRACE-OUT>
        <RETURN .F>
      )
      (ELSE
        ;"TODO: Do this check when we're matching YSPECs, so each YSPEC can be
          disambiguated individually."
        ;"Try narrowing the search if we can."
        <COND 
          (<N=? .BITS .OBITS>
            <TRACE 4 "[narrowing scope to BITS=" N .OBITS "]" CR>
            <SET BITS .OBITS>
            <AGAIN .BITS-SET>
          )
        >
        <COND
          (<SET F <APPLY-GENERIC-FCN .OUT>>
            <TRACE 4 "[GENERIC chose " T .F "]" CR>
            <PUT/B .OUT 1 .F>
            <PUTB .OUT 0 1>
            <TRACE-OUT>
            <RETURN .F>
          )
        >
        <WHICH-DO-YOU-MEAN .OUT>
        <COND
          (<=? .NP ,P-NP-DOBJ>
            <ORPHAN T AMBIGUOUS PRSO>
          )
          (ELSE
            <ORPHAN T AMBIGUOUS PRSI>
          )
        >
        <TRACE-OUT>
        <RFALSE>
      )
    >
  >
>
