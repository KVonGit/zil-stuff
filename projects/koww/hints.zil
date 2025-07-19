"HINTS for
		The Adventures of Koww the Magician"

;"============================================================================="
;"
	Hints (InvisiClue-style)
    ------------------------
	Skeleton file to add a InvisiClue-style hintsystem to your story. The original 
	file (hint.zil) is from the project 'hitchhiker-invclues-r31' (Solid Gold-version) 
	at https://github.com/historicalsource/hitchhikersguide-gold/blob/master/hints.zil
	To make it work we only needed to add the code in the 'Added stuff'-section.
	To make your own hints you need to add text in the <GLOBAL HINTS>-structure.
"
;"============================================================================="

;"============================================================================="
;"Added stuff"
;"============================================================================="

<CONSTANT S-TEXT 0>
<CONSTANT S-WINDOW 1>

<CONSTANT D-TABLE-ON 3>
<CONSTANT D-TABLE-OFF -3>

<ROUTINE PRINT-SPACES (CNT)
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<PRINTC 32>)>>>

<SYNTAX HELP = V-HINTS>
<SYNTAX HELP OFF OBJECT (FIND KLUDGEBIT) = V-HINTS-NO>
<VERB-SYNONYM HELP HINT HINTS CLUE CLUES VISICLUES INVISICLUES>

;"======================================================================"
;"Here starts the orginal hints.zil from HITCHHIKERS GUIDE TO THE GALAXY
  There are some small changes to the routines V-HINTS and V-HINTS-NO."
;"======================================================================"

<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINT-WARNING <>>

<GLOBAL HINTS-OFF <>>

<ROUTINE V-HINTS-NO ()
	<COND (,HINTS-OFF
	       <TELL "I don't understand what you mean." CR>)
	      (T
	       <SETG HINTS-OFF T>
	       <TELL "[Hints have been disallowed for this session.]" CR>)>
	<RFATAL>>

<ROUTINE V-HINTS ("AUX" CHR MAXC (C <>) Q)
	<COND (,HINTS-OFF
	       <PERFORM ,V?HINTS-NO>
	       <RFATAL>)
	      (<NOT ,HINT-WARNING>
	       <SETG HINT-WARNING T>
	       <TELL
"[Warning: It is recognized that the temptation for help may at times be so
exceedingly strong that you might fetch hints prematurely. Therefore, you may
at any time during the story type HINTS OFF, and this will disallow the
seeking out of help for the present session of the story. If you still want a
hint now, indicate HINT.]" CR>
	       <RFATAL>)>
       	<SET MAXC <GET ,HINTS 0>>
	<INIT-HINT-SCREEN>
	<CURSET 5 1>
	<PUT-UP-CHAPTERS>
	<SETG CUR-POS <- ,CHAPT-NUM 1>>
	<NEW-CURSOR>
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q> %131>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n> %130>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,CHAPT-NUM .MAXC>
			      <SETG CUR-POS 0>
			      <SETG CHAPT-NUM 1>
			      <SETG QUEST-NUM 1>)
			     (T 
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG CHAPT-NUM <+ ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p> %129>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,CHAPT-NUM 1>
			      <SETG CHAPT-NUM .MAXC>
			      <SETG CUR-POS <- ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>>
			      <SETG CHAPT-NUM <- ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10 %132>
		       <PICK-QUESTION>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>	;"AGAIN does whole routine?")>
	<CLEAR -1>
	<INIT-STATUS-LINE>
	<TELL CR "Back to the game..." CR CR>
  <V-LOOK>
	<RFATAL>>


<ROUTINE PICK-QUESTION ("AUX" CHR MAXQ (Q <>))
	<INIT-HINT-SCREEN <>>
	<LEFT-LINE 3 " RETURN = See hint">
	<RIGHT-LINE 3 "Q = Main menu" %<LENGTH "Q = Main menu">>
	<SET MAXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<CURSET 5 1>
	<PUT-UP-QUESTIONS>
	<SETG CUR-POS <- ,QUEST-NUM 1>>
	<NEW-CURSOR>
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q> %131>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n> %130>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM .MAXQ>
			      <SETG CUR-POS 0>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG QUEST-NUM <+ ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p> %129>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM 1>
			      <SETG QUEST-NUM .MAXQ>
			      <SETG CUR-POS <- ,QUEST-NUM 1>>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>> 
			      <SETG QUEST-NUM <- ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10  %132>
		       <DISPLAY-HINT>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>)>>

;"zeroth (first) element is 5"
<GLOBAL LINE-TABLE
	<PTABLE
	  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22>>

;"zeroth (first) element is 4"
<GLOBAL COLUMN-TABLE
	<PTABLE
	  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4>>

<GLOBAL CUR-POS 0>	;"determines where to place the highlight cursor
			  Can go up to 17 Questions"

<GLOBAL QUEST-NUM 1>	;"shows in HINT-TBL ltable which QUESTION it's on"

<GLOBAL CHAPT-NUM 1>	;"shows in HINT-TBL ltable which CHAPTER it's on"

<ROUTINE ERASE-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL " ">	;"erase previous highlight cursor">

;"go back 2 spaces from question text, print cursor and flash is between
the cursor and text"

<ROUTINE NEW-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL ">">	;"print the new cursor">

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	<HLIGHT ,H-INVERSE>
	<PRINT-SPACES <LOWCORE SCRH>>
	<HLIGHT ,H-NORMAL>>

;"cnt (3) is where in table answers begin. (2) in table is # of hints-seen"
<ROUTINE DISPLAY-HINT ("AUX" H MX MXC (CNT 2) CHR (FLG T) N)
	;<SPLIT 0>
	<CLEAR -1>
	<SPLIT 3>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<CURSET 3 1>
	<INVERSE-LINE>
	<LEFT-LINE 3 " RETURN = See hint">
	<RIGHT-LINE 3 "Q = See hint menu" %<LENGTH "Q = See hint menu">>
	<CURSET 2 1>
	<INVERSE-LINE>
	<HLIGHT ,H-BOLD>
	<SET H <GET <GET ,HINTS ,CHAPT-NUM> <+ ,QUEST-NUM 1>>>
	<CENTER-LINE 2 <GET .H 2>>
	<HLIGHT ,H-NORMAL>
	<SET MX <GET .H 0>>
	<SET MXC <GET ,HINTS 0>> 
	<SCREEN ,S-TEXT>
	<CRLF>
	<REPEAT ()
	       <COND (<EQUAL? .CNT <GET .H 1>>
		      <RETURN>)
		     (T
		      <TELL <GET .H .CNT> CR ;CR>
		      <SET CNT <+ .CNT 1>>)>>
	<REPEAT ()
	      <COND (<AND .FLG <G? .CNT .MX>>
		     <SET FLG <>>
		     <TELL "[That's all.]" CR>)
		    (.FLG
		     <SET N <+ <- .MX .CNT> 1>> ;"added +1 - Jeff"
		     <COND (<NOT <EQUAL? ,CHAPT-NUM .MXC>> ;"add cond-GARY" 
		            <TELL N .N " hint">
		            <COND (<NOT <EQUAL? .N 1>>
			           <TELL "s">)>
		            <TELL " left " ;CR ;CR>)> ;"removed CRs - GARY"
		     <TELL "-> ">
		     <SET FLG <>>)>
	      <SET CHR <INPUT 1>>
	      <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q> %131>
		     <PUT .H 1 .CNT>
		     <RETURN>)
		    (<EQUAL? .CHR 13 10>
		     <COND (<NOT <G? .CNT .MX>>
			    <SET FLG T>	;".cnt starts as 3" 
			    <TELL <GET .H .CNT>>
			    ;<CRLF> ;"extra CRLF removed by GARY"
			    <CRLF>
			    <SET CNT <+ .CNT 1>>
			    <COND (<G? .CNT .MX>
				   <SET FLG <>>
				   <TELL "[That's all.]" CR>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS ("AUX" (ST 1) MXQ MXL)
	<SET MXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXQ>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
		<TELL " " <GET <GET <GET ,HINTS ,CHAPT-NUM> <+ .ST 1>> 2>>
		<SET ST <+ .ST 1>>>>

<ROUTINE PUT-UP-CHAPTERS ("AUX" (ST 1) MXC MXL)
	<SET MXC <GET ,HINTS 0>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXC>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
		<TELL " " <GET <GET ,HINTS .ST> 1>>
		<SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T))
	;<SPLIT 0>
	<CLEAR -1>
	<SPLIT <- <GETB 0 32> 1>>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CURSET 2 1>
	<INVERSE-LINE>
	<CURSET 3 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<LEFT-LINE 2 " N = Next">
	<RIGHT-LINE 2 "P = Previous" %<LENGTH "P = Previous">>
	<COND (<T? .THIRD>
	      <LEFT-LINE 3 " RETURN = See topics">
	      <RIGHT-LINE 3 "Q = Resume story" %<LENGTH "Q = Resume story">>)>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT ,D-TABLE-ON ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT ,D-TABLE-OFF>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <+ </ <- <LOWCORE SCRH> .LEN> 2> 1>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	<CURSET .LN 1>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT 3 ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT -3>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <- <LOWCORE SCRH> .LEN>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<GLOBAL DIROUT-TBL
	<TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 >>

;"longest hint topic can be 17 questions long, longest question 36 characters"


;"longest hint topic can be 17 questions long, longest question 36 characters"

<GLOBAL HINTS
	<PLTABLE
    	;"Table of chapters."
      <PLTABLE 
        "KOWW'S CHASM"
			<LTABLE 3
				"How do I get across the chasm?"
				"Did you try to FLY?"
				"If you don't have the Fly Scroll, you can't fly."
				"The Resplendent Magnicifent Phoenix can help you.">
      <LTABLE 3
        "What do I do with this sign?"
        "Have you tried reading it?"
        "That's it. Just read it!">>
		<PLTABLE
			"ZEKE'S FARM"
			<LTABLE 3
				"What do I do with the haystack?"
				"Did you try eating it?"
				"You need to stab it with the pitchfork."
        "You will get a jade statuette after stabbing the haystack with the pitchfork.">
			<LTABLE 3
				"What about the pond?"
				"Try throwing something into it."
        "You can get something for nothing from the Goblin guard."
        "If you throw something into the pond, you will acquire a duck turd.">
			<LTABLE 3
				"How do I get into the farmhouse or the silo?"
				"Try ENTER FARMHOUSE or ENTER SILO.">>
		<PLTABLE
			"IN ZEKE'S FARMHOUSE"
			<LTABLE 3
				"I'm in the farmhouse. Now what?"
				"Examine the table."
				"Examine the chest on the table."
        "Open the chest."
        "That's it. You acquire... nothing!"
        "That's all there is to do in the farmhouse.">>
        <PLTABLE
            "IN ZEKE'S SILO"
            <LTABLE 3
                "What do I do with Zeke?"
                "Speak to him!"
                "GIVE MILK TO ZEKE to acquire the pitchfork.">>
		<PLTABLE
            "ON GOBLIN TRAIL"
            <LTABLE 3
                "What am I doing here?"
                "Taking the road north or south.">>
        <PLTABLE
            "GOBLIN LAIR"
            <LTABLE 3
                "What do I do with the Goblin guard?"
                "Have you tried talking to him?"
                "He wants nothing."
                "Give him nothing."
                "He'll give you something in exchange for nothing.">
            <LTABLE 3
              "How do I get into the complex?"
              "ENTER CAVE">>
        <PLTABLE
            "INSIDE THE GOBLIN LAIR"
            <LTABLE 3
                "What does the Goblin King want?"
                "Give him the jade statuette."
                "Give him the duck turd, too.">>
        <PLTABLE
            "LAND OF THE NECROYAKS"
            <LTABLE 3
                "What to do here?"
                "Go north or south.">>
        <PLTABLE
            "DEEP IN NECROYAK TERRITORY"
            <LTABLE 3
                "Every time I try to SEARCH, I die!"
                "Don't search until you have the goblin spit."
                "Give the jade statuette to the Goblin King to acquire the goblin spit.">>
        <PLTABLE
            "PHOENIX MOUNTAIN PASS"
            <LTABLE 3
                "How to I climb these mountains?"
                "You need a grappling hook."
                "Give the duck turd to the Goblin King to get a grappling hook.">>
        <PLTABLE
          "PHOENIX PEAK"
          <LTABLE 3
            "What does the Resplendent Magnificent Phoenix want from me?"
            "SPEAK TO HIM to find out!"
            "He wants is wing feather."
            "Give him his wing feather, and he'll give you the Fly Scroll.">>
        <PLTABLE
          "MISCELLANEOUS"
            <LTABLE 3
              "HOW ALL THE POINTS ARE SCORED"
              "This section should only be used as a last resort, or for your own interest after you've completed the game."
              "  SCORE   ACTION"
              "     40   Giving some milk to Zeke"                                          ;D
              "    40   Using the pitchfork on the haystack"                                ;D
              "     40   Throwing something into the pond"                               ;D
              "    40   Getting nothing from the treasure chest"                         ;D
              "     40   Giving nothing to the Goblin guard"                                       ;D
              "    40   Giving the jade statuette to the Goblin King"                                             ;D
              "    40   Giving the duck turd to the Goblin King"                                    ;D
              "     40   Searching while Deep in NecroYak territory without getting killed"                             ;D
              "     19   Successfully climbing the mountains"                                    ;D
              "     40   Giving the Resplendent Magnificent Phoenix his wing feather"                           ;D
              "     40   Using the Fly Scroll"                                ;D
              "      1   Using the purple paint"                                     ;D
              "    420   TOTAL POINTS">
            <LTABLE 3
              "FOR YOUR AMUSEMENT"
              "You shouldn't develop anything in this section until you've finished the game. Things in the
      section will invariably give away the answers to puzzles in the game."
              "Have you tried..."
              "splashing milk on Zeke"
              "taking the sign"
              "taking the road">>
		<PLTABLE
			"GENERAL COMMANDS"
			<LTABLE 3
				"MOVING AROUND ROOMS"
				"You can type commands such as GO NORTH( which can be simplified to N), SOUTH( simplified to S),
E( for EAST), and W( for WEST), Followed by the ENTER button. [Press ENTER to get another hint.]"
				"As well as UP, DOWN, IN & OUT."
				"And, NE(northeast), NW(northwest), SE(southeast), and SW(southwest)."
				"When you are stuck on where you can move, LOOK AROUND for some exits in the room description.|
[To return to the previous menu, press Q, or to return to playing the game, press the escape key.]">
			<LTABLE 3
				"ADDITIONAL COMMANDS"
				"Some helpful verbs you will need are..."
				"...I - for your INVENTORY..."
				"...L - to LOOK AROUND..."
				"...X [object] - EXAMINE [object]..."
				"...TAKE/DROP [object]..."
				"...SMELL, FEEL, TASTE, LISTEN..."
				"...YES/NO (in response to a question by the computer, or a person)..."
				"...And other commands. (Once you are done with typing out your command, press ENTER to get the response.)|
To return to the previous menu, press Q, or to return to playing the game, press the escape key.">
            <LTABLE 3
				"EXAMPLE COMMANDS"
				"GO TO THE NORTH."
				"GO UP."
				"NE."
				"SOUTH."
				"SPEAK TO ZEKE."
				"THROW THE FOO AT THE BAR."
				"GO NORTH AND THEN EAST."
				"YES."
				"GIVE BAR TO FOO."
				"USE THE FOO."
        "USE THE FOO ON THE BAR.">>>>