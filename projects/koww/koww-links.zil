"LINKS file for The Adventures of Koww the Magician"

<GLOBAL SHOW-LINKS <>>

<ROUTINE OBJECT-LINK (NM "OPT" AL)
  <COND
    (<NOT <ASSIGNED? AL>>
      <SET AL .NM>
    )
  >
  <COND
    (<==? ,SHOW-LINKS T>
      <TELL "<span class=\"object-link dropdown\" data-objname=\"" .NM "\">">
      <TELL "<span onclick=\"itemLinks.itemClick(this, event)\" obj=\"" .NM "\" class=\"droplink\">" .AL "</span>">
      <TELL "<span obj=\"" .NM "\" class=\"dropdown-content\">">
      <TELL "<span class=\"" .NM "-verbs-list-holder\">">
      <TELL "<a href=\"#\" onclick=\"sendCmd('examine " .AL "')\">Examine</a><br>">
      <TELL "<a href=\"#\" onclick=\"sendCmd('take " .AL "')\">Take</a>">
      <COND
        (<==? .NM "treasure chest">
          <TELL "<br/><a href=\"#\" onclick=\"sendCmd('">
          <COND 
            (<FSET? ,TREASURE-CHEST ,OPENBIT>
              <TELL "close ">
            )
            (ELSE
              <TELL "open ">
            )
          >
          <TELL .AL "')\">">
          <COND 
            (<FSET? ,TREASURE-CHEST ,OPENBIT>
              <TELL "Close">
            )
            (ELSE
              <TELL "Open">
            )
          >
          <TELL "</a>">
        )
        (<==? .NM "mountains">
          <TELL "<br><a href=\"#\" onclick=\"sendCmd('climb " .AL "')\">Climb</a>">
        )
        (<OR <==? .NM "cliff"><==? .NM "cliff face">>
          <TELL "<br><a href=\"#\" onclick=\"sendCmd('climb " .AL "')\">Climb</a>">
          <TELL "<br><a href=\"#\" onclick=\"sendCmd('search " .AL "')\">Search</a>">
        )
        (<==? .NM "sign">
          <TELL "<br><a href=\"#\" onclick=\"sendCmd('read " .AL "')\">Read</a>">
        )
      >
      <TELL "</span></span></span>">
    )
    (T
      <BOLDIZE .AL>
    )
  >
>

<ROUTINE NPC-LINK (NM "OPT" AL)
  <COND
    (<NOT <ASSIGNED? AL>>
      <SET AL .NM>
    )
  >
  <COND
    (<==? ,SHOW-LINKS T>
      <TELL "<span class=\"object-link dropdown\" data-objname=\"" .NM "\">">
      <TELL "<span onclick=\"itemLinks.itemClick(this, event)\" obj=\"" .NM "\" class=\"droplink\">" .AL "</span>">
      <TELL "<span obj=\"" .NM "\" class=\"dropdown-content\">">
      <TELL "<span obj=\"" .NM "-verbs-list-holder\">">
      <TELL "<a href=\"#\" onclick=\"sendCmd('examine " .AL "')\">Examine</a><br>">
      <TELL "<a href=\"#\" onclick=\"sendCmd('speak to " .AL "')\">Speak to</a>">
      <TELL "</span></span></span>">
    )
    (T
      <BOLDIZE .AL>
    )
  >
>

<ROUTINE EXIT-LINK (TXT "OPT" DISPLAYTXT)
  <COND 
    (<NOT <ASSIGNED? DISPLAYTXT>>
      <SET DISPLAYTXT .TXT>
    )
  >
  <COND
    (<==? ,SHOW-LINKS T>
      <TELL "<a class=\"exit-link\" onclick=\"sendCmd('" .TXT "');\">" .DISPLAYTXT "</a>">
    )
    (T
      <BOLDIZE .DISPLAYTXT>
    )
  >
>

<ROUTINE ADD-JS-SCRIPT (SCRIPT)
  <AND <==? ,SHOW-LINKS T><TELL "<script>" .SCRIPT "</script>" CR>>
>

<ROUTINE GOTO (RM "AUX" WAS-LIT F (OWINNER <>))

    <COND (<ORDERING?>
           <SET OWINNER ,WINNER>
           <RESET-WINNER>)>
    <SET WAS-LIT ,HERE-LIT>
    <SETG HERE .RM>
    <MOVE ,WINNER ,HERE>
    <APPLY <GETP .RM ,P?ACTION> ,M-ENTER>
    <AND
      <==? ,SHOW-LINKS T>
      <TELL "<script>zilJs.currentRoom = \"" <GETP .RM ,P?PNAME> "\";</script>" CR>
      <UPDATE-EXITS-JS>
    >
    ;"Call SEARCH-FOR-LIGHT down here in case M-ENTER adjusts the light."
    <SETG HERE-LIT <SEARCH-FOR-LIGHT>>
    ;"moved descriptors into GOTO so they'll be called when you call GOTO from a PER routine, etc"
    <COND (<NOT .WAS-LIT>
           <COND (,HERE-LIT
                  <SET F <DARKNESS-F ,M-DARK-TO-LIT>>)
                 (<OR <DARKNESS-F ,M-DARK-TO-DARK>
                      <DARKNESS-F ,M-LOOK>>
                  <SET F T>)>)
          (,HERE-LIT)
          (<OR <DARKNESS-F ,M-LIT-TO-DARK>
               <DARKNESS-F ,M-LOOK>>
           <SET F T>)>
    <COND (<AND <NOT .F> <DESCRIBE-ROOM ,HERE>>
           <DESCRIBE-OBJECTS ,HERE>)>
    <COND (,HERE-LIT <FSET ,HERE ,TOUCHBIT>)>
    <COND (.OWINNER <SETG WINNER .OWINNER>)>
    <RTRUE>>

<ROUTINE V-REMOVE-LAST-COMMAND-ECHO ()
  <ADD-JS-SCRIPT "$('.Style_input').last().parent().remove()">
>

<SYNTAX JSREMCMD = V-REMOVE-LAST-COMMAND-ECHO>

<ROUTINE ITEM-LINK (OBJ "OPT" AL "AUX" DISPNAME)
  <SET DISPNAME <GETP .OBJ ,P?SDESC>>
  <COND
    (<NOT <ASSIGNED? AL>>
      <SET AL .DISPNAME>
    )
  >
  <COND
    (<==? .DISPNAME "your milk">
      <SET .DISPNAME "milk">
    )
  >
  <COND
    (<==? ,SHOW-LINKS T>
      <TELL "<span class=\"object-link dropdown\" data-objname=\"" .DISPNAME "\">">
      <TELL "<span onclick=\"itemLinks.itemClick(this, event)\" obj=\"" .DISPNAME "\" class=\"droplink\">" .AL "</span>">
      <TELL "<span obj=\"" .DISPNAME "\" class=\"dropdown-content\">">
      <TELL "<span obj=\"" .DISPNAME "-verbs-list-holder\">">
      <TELL "<a href=\"#\" onclick=\"sendCmd('examine " .DISPNAME "')\">Examine</a>">
      <AND <FSET? .OBJ ,GIVEBIT><TELL "<br/><a href=\"#\" onclick=\"sendCmd('give " .DISPNAME "')\">Give</a>">>
      <AND <FSET? .OBJ ,USEBIT><TELL "<br/><a href=\"#\" onclick=\"sendCmd('use " .DISPNAME "')\">Use</a>">>
      <TELL "</span></span></span>">
    )
    (T
      <BOLDIZE .AL>
    )
  >
>

<ROUTINE V-INVENTORY ()
    ;"check for light first"
    <COND (,HERE-LIT
           <COND (<FIRST? ,WINNER>
                  <TELL "Items:" CR>
                  <MAP-CONTENTS (I ,WINNER)
                      <TELL "   ">
                      <COND
                        (<==? ,SHOW-LINKS T>
                          <TELL <GET-ARTICLE .I T>>
                          <ITEM-LINK .I>
                        )
                        (ELSE
                          <TELL A .I>
                        )
                      >
                      <AND <NOT <==? <GETP .I ,P?SUFFIX> <>> > <TELL " " <GETP .I ,P?SUFFIX> > >
                      <AND <FSET? .I ,WORNBIT> <TELL " (worn)">>
                      <AND <FSET? .I ,LIGHTBIT> <TELL " (providing light)">>
                      <COND (<FSET? .I ,CONTBIT>
                             <COND (<FSET? .I ,OPENABLEBIT>
                                    <COND (<FSET? .I ,OPENBIT> <TELL " (open)">)
                                          (ELSE <TELL " (closed)">)>)>
                             <COND (<SEE-INSIDE? .I> <INV-DESCRIBE-CONTENTS .I>)>)>
                      <CRLF>>)
                 (ELSE
                  <TELL "You are empty-handed." CR>)>)
          (ELSE
           <TELL "It's too dark to see what you're carrying." CR>)>>

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
hint now, indicate HINTS.]" CR>
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
  <ADD-JS-SCRIPT "$('#toolbar').show();">
  <V-LOOK>
	<RFATAL>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T))
	;<SPLIT 0>
	<CLEAR -1>
  <ADD-JS-SCRIPT "$('#toolbar').hide();">
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

<ROUTINE UPDATE-EXITS-JS ("AUX" FIRST)
  <COND
    (<NOT <==? ,SHOW-LINKS T>>
      <RFALSE>
    )
  >
  <SET FIRST T>
  <TELL "<script>updateExits([">
  <MAP-DIRECTIONS (D PT ,HERE)
    <COND
      (<=? <PTSIZE .PT> ,NEXIT>
        ;"do nothing"
      )
      (<==? .FIRST T>
        <SET FIRST <>>
      )
      (T
        <TELL ",">
      )
    >
    <COND
      (<N=? <PTSIZE .PT> ,NEXIT>
        <PRINT-MATCHING-WORD-SINGLE-QUOTE .D ,PS?DIRECTION ,P1?DIRECTION>
      )
    >
  >
  <TELL "]);</script>" CR>
>

<ROUTINE PRINT-MATCHING-WORD-SINGLE-QUOTE (V PS P1 "AUX" W CNT SIZE)
  <COND (<0? .V> <TELL "---"> <RTRUE>)>
  <SET W ,VOCAB>
  <SET W <+ .W 1 <GETB .W 0>>>
  <SET SIZE <GETB .W 0>>
  <SET W <+ .W 1>>
  <SET CNT <GET .W 0>>
  <SET W <+ .W 2>>
  <DO (I 1 .CNT)
     <COND (<=? <CHKWORD? .W .PS .P1> .V>
            <TELL "'" B .W "'">
            <RTRUE>)>
     <SET W <+ .W .SIZE>>>
  <TELL "???">>



<ROUTINE FIX-LINKS-AFTER-UNDO ()
  <AND <NOT <==? ,SHOW-LINKS T>><RFALSE>>
  <TELL "<script>zilJs.currentRoom = \"" <GETP ,HERE ,P?PNAME> "\";</script>" CR>
  <UPDATE-EXITS-JS>
>

<ROUTINE PARSER ("AUX" NOBJ VAL DIR DIR-WN O-R KEEP OW OH OHL)
    ;"Need to (re)initialize locals here since we use AGAIN"
    <SET OW ,WINNER>
    <SET OH ,HERE>
    <SET OHL ,HERE-LIT>
    <SET NOBJ <>>
    <SET VAL <>>
    <SET DIR <>>
    <SET DIR-WN <>>
    ;"Fill READBUF and LEXBUF"
    <COND (<L? ,P-CONT 0> <SETG P-CONT 0>)>
    <COND (,P-CONT
           <TRACE 1 "[PARSER: continuing from word " N ,P-CONT "]" CR>
           <ACTIVATE-BUFS "CONT">
           <COND (<1? ,P-CONT> <SETG P-CONT 0>)
                 (<N=? ,MODE ,SUPERBRIEF>
                  ;"Print a blank line between multiple commands"
                  <COND (<NOT <VERB? TELL>> <CRLF>)>)>)
          (ELSE
           <TRACE 1 "[PARSER: fresh input]" CR>
           <RESET-WINNER>
           <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		          <SETG HERE <LOC ,WINNER>>)>
           <SETG HERE-LIT <SEARCH-FOR-LIGHT>>
           <READLINE T>)>

    <IF-DEBUG <SETG TRACE-INDENT 0>>
    <TRACE-DO 1 <DUMPBUFS> ;<DUMPLINE>>
    <TRACE-IN>

    <SETG P-LEN <GETB ,LEXBUF 1>>
    <COND (<0? ,P-LEN>
           <TELL "I beg your pardon?" CR>
           <SETG P-CONT 0>
           <RFALSE>)>

    ;"Save undo state unless this looks like an undo command"
    <IF-UNDO
        <COND (<AND <G=? ,P-LEN 1>
                    <=? <GETWORD? 1> ,W?UNDO>
                    <OR <1? ,P-LEN>
                        <=? <GETWORD? 2> ,W?\. ,W?THEN>>>)
              (ELSE
               <TRACE 4 "[saving for UNDO]" CR>
               <BIND ((RES <ISAVE>))
                   <COND (<=? .RES 2>
                          <TELL "Previous turn undone." CR CR>
                          <SETG WINNER .OW>
                          <SETG HERE .OH>
                          <SETG HERE-LIT .OHL>
                          <V-LOOK>
                          <FIX-LINKS-AFTER-UNDO>
                          <SETG P-CONT 0>
                          <AGAIN>)
                         (ELSE
                          <SETG USAVE .RES>)>>)>>

    <COND (<0? ,P-CONT>
           ;"Handle OOPS"
           <COND (<AND ,P-LEN <=? <GETWORD? 1> ,W?OOPS>>
                  <COND (<=? ,P-LEN 2>
                         <COND (<P-OOPS-WN>
                                <TRACE 2 "[handling OOPS]" CR>
                                <HANDLE-OOPS 2>
                                <SETG P-LEN <GETB ,LEXBUF 1>>
                                <TRACE-DO 1 <DUMPLINE>>)
                               (ELSE
                                <TELL "Nothing to correct." CR>
                                <RFALSE>)>)
                        (<=? ,P-LEN 1>
                         <TELL "It's OK." CR>
                         <RFALSE>)
                        (ELSE
                         <TELL "You can only correct one word at a time." CR>
                         <RFALSE>)>)>)>

    <SET KEEP 0>
    <P-OOPS-WN 0>
    <P-OOPS-CONT 0>
    <P-OOPS-O-REASON ,P-O-REASON>

    <COND (<0? ,P-CONT>
           ;"Save command in edit buffer for OOPS"
           <COND (<N=? ,READBUF ,EDIT-READBUF>
                  <COPY-TO-BUFS "EDIT">
                  <ACTIVATE-BUFS "EDIT">)>
           ;"Handle an orphan response, which may abort parsing or ask us to skip steps"
           <COND (<ORPHANING?>
                  <SET O-R <HANDLE-ORPHAN-RESPONSE>>
                  <COND (<N=? .O-R ,O-RES-NOT-HANDLED>
                         <SETG WINNER .OW>
                         <SETG HERE .OH>
                         <SETG HERE-LIT .OHL>)>
                  <COND (<=? .O-R ,O-RES-REORPHANED>
                         <TRACE-OUT>
                         <RFALSE>)
                        (<=? .O-R ,O-RES-FAILED>
                         <SETG P-O-REASON <>>
                         <TRACE-OUT>
                         <RFALSE>)
                        (<=? .O-R ,O-RES-SET-NP>
                         ;"TODO: Set the P-variables somewhere else? Shouldn't we fill in what
                           we know about the command-to-be when we ask the orphaning question, not
                           when we get the response?"
                         <SETG P-P1 <GETB ,P-SYNTAX ,SYN-PREP1>>
                         <COND (<ORPHANING-PRSI?>
                                <SETG P-P2 <GETB ,P-SYNTAX ,SYN-PREP2>>
                                <SETG P-NOBJ 2>
                                ;"Don't re-match P-NP-DOBJ when we've just orphaned PRSI. Use the saved
                                  match results. There won't be a NP to match if we GWIMmed PRSO."
                                <SET KEEP 1>)
                               (ELSE <SETG P-NOBJ 1>)>)
                        (<=? .O-R ,O-RES-SET-PRSTBL>
                         <COND (<ORPHANING-PRSI?> <SET KEEP 2>)
                               (ELSE <SET KEEP 1>)>)>
                  <SETG P-O-REASON <>>)>
           ;"If we aren't handling this command as an orphan response, convert it if needed
             and copy it to CONT bufs"
           <COND (<NOT .O-R>
                  ;"Translate order syntax (HAL, OPEN THE POD BAY DOOR or
                    TELL HAL TO OPEN THE POD BAY DOOR) into multi-command syntax
                    (\,TELL HAL THEN OPEN THE POD BAY DOOR)."
                  <COND (<CONVERT-ORDER-TO-TELL?>
                         <SETG P-LEN <GETB ,LEXBUF 1>>)>)>)>

    ;"Identify parts of speech, parse noun phrases"
    <COND (<N=? .O-R ,O-RES-SET-NP ,O-RES-SET-PRSTBL>
           <SETG P-V <>>
           <SETG P-NOBJ 0>
           <CLEAR-NOUN-PHRASE ,P-NP-DOBJ>
           <CLEAR-NOUN-PHRASE ,P-NP-IOBJ>
           <SETG P-P1 <>>
           <SETG P-P2 <>>
           ;"Identify the verb, prepositions, and noun phrases"
           <REPEAT ((I <OR ,P-CONT 1>) W V)
               <COND (<G? .I ,P-LEN>
                      ;"Reached the end of the command"
                      <SETG P-CONT 0>
                      <RETURN>)
                     (<NOT <OR <SET W <GETWORD? .I>>
                               <AND <PARSE-NUMBER? .I> <SET W ,W?\,NUMBER>>>>
                      ;"Word not in vocabulary"
                      <STORE-OOPS .I>
                      <SETG P-CONT 0>
                      <TELL "I don't know the word \"" WORD .I "\"." CR>
                      <RFALSE>)
                     (<=? .W ,W?THEN ,W?\.>
                      ;"End of command, maybe start of a new one"
                      <TRACE 3 "['then' word " N .I "]" CR>
                      <SETG P-CONT <+ .I 1>>
                      <COND (<G? ,P-CONT ,P-LEN> <SETG P-CONT 0>)
                            (ELSE <COPY-TO-BUFS "CONT">)>
                      <RETURN>)
                     (<AND <NOT ,P-V>
                           <SET V <WORD? .W VERB>>
                           <OR <NOT .DIR> <=? .V ,ACT?WALK>>>
                      ;"Found the verb"
                      <SETG P-V-WORD .W>
                      <SETG P-V-WORDN .I>
                      <SETG P-V .V>
                      <TRACE 3 "[verb word " N ,P-V-WORDN " '" B ,P-V-WORD "' = " N ,P-V "]" CR>)
                     (<AND <NOT .DIR>
                           <EQUAL? ,P-V <> ,ACT?WALK>
                           <SET VAL <WORD? .W DIRECTION>>>
                      ;"Found a direction"
                      <SET DIR .VAL>
                      <SET DIR-WN .I>
                      <TRACE 3 "[got a direction]" CR>)
                     (<SET VAL <CHKWORD? .W ,PS?PREPOSITION 0>>
                      ;"Found a preposition"
                      ;"Only keep the first preposition for each object"
                      <COND (<AND <==? .NOBJ 0> <NOT ,P-P1>>
                             <TRACE 3 "[P1 word " N .I " '" B .W "' = " N .VAL "]" CR>
                             <SETG P-P1 .VAL>)
                            (<AND <==? .NOBJ 1> <NOT ,P-P2>>
                             <TRACE 3 "[P2 word " N .I " '" B .W "' = " N .VAL "]" CR>
                             <SETG P-P2 .VAL>)>)
                     (<STARTS-NOUN-PHRASE? .W>
                      ;"Found a noun phrase"
                      <SET NOBJ <+ .NOBJ 1>>
                      <TRACE 3 "[NP start word " N .I ", now NOBJ=" N .NOBJ "]" CR>
                      <TRACE-IN>
                      <COND (<==? .NOBJ 1>
                             ;"If we found a direction earlier, try it as a preposition instead"
                             ;"This fixes GO IN BUILDING (vs. GO IN)"
                             <COND (<AND .DIR
                                         ,P-V
                                         <NOT ,P-P1>
                                         <SET V <GETWORD? .DIR-WN>>
                                         <SET VAL <CHKWORD? .V ,PS?PREPOSITION 0>>>
                                    <TRACE 3 "[revising direction word " N .DIR-WN
                                             " as P1: '" B .V "' = " N .VAL "]" CR>
                                    <SETG P-P1 .VAL>
                                    <SET DIR <>>
                                    <SET DIR-WN <>>)>
                             <SET VAL <PARSE-NOUN-PHRASE .I ,P-NP-DOBJ>>)
                            (<==? .NOBJ 2>
                             <SET VAL <PARSE-NOUN-PHRASE .I ,P-NP-IOBJ>>)
                            (ELSE
                             <SETG P-CONT 0>
                             <TELL "That sentence has too many objects." CR>
                             <RFALSE>)>
                      <TRACE 3 "[PARSE-NOUN-PHRASE returned " N .VAL "]" CR>
                      <TRACE-OUT>
                      <COND (.VAL
                             <SET I .VAL>
                             <AGAIN>)
                            (ELSE
                             <SETG P-CONT 0>
                             <RFALSE>)>)
                     (ELSE
                      ;"Unexpected word type"
                      <STORE-OOPS .I>
                      <SETG P-CONT 0>
                      <TELL "I didn't expect the word \"" WORD .I "\" there." CR>
                      <TRACE-OUT>
                      <RFALSE>)>
               <SET I <+ .I 1>>>

           <SETG P-NOBJ .NOBJ>

           <TRACE-OUT>
           <TRACE 1 "[sentence: V=" MATCHING-WORD ,P-V ,PS?VERB ,P1?VERB "(" N ,P-V ") NOBJ=" N ,P-NOBJ
                 " P1=" MATCHING-WORD ,P-P1 ,PS?PREPOSITION 0 "(" N ,P-P1
                 ") DOBJS=+" N <NP-YCNT ,P-NP-DOBJ> "-" N <NP-NCNT ,P-NP-DOBJ>
                 " P2=" MATCHING-WORD ,P-P2 ,PS?PREPOSITION 0 "(" N ,P-P2
                 ") IOBJS=+" N <NP-YCNT ,P-NP-IOBJ> "-" N <NP-NCNT ,P-NP-IOBJ> "]" CR>
           <TRACE-IN>

           ;"If we have a direction and nothing else except maybe a WALK verb, it's
             a movement command."
           <COND (<AND .DIR
                       <EQUAL? ,P-V <> ,ACT?WALK>
                       <0? .NOBJ>
                       <NOT ,P-P1>
                       <NOT ,P-P2>>
                  <SETG PRSO-DIR T>
                  <SETG PRSA ,V?WALK>
                  <SETG PRSO .DIR>
                  <SETG PRSI <>>
                  <COND (<NOT <VERB? AGAIN>>
                         <TRACE 4 "[saving for AGAIN]" CR>
                         <SAVE-PARSER-RESULT ,AGAIN-STORAGE>)>
                  <TRACE-OUT>
                  <RTRUE>)>
           ;"Otherwise, a verb is required and a direction is forbidden."
           <COND (<NOT ,P-V>
                  <SETG P-CONT 0>
                  <TELL "That sentence has no verb." CR>
                  <TRACE-OUT>
                  <RFALSE>)
                 (.DIR
                  <STORE-OOPS .DIR-WN>
                  <SETG P-CONT 0>
                  <TELL "I don't understand what \"" WORD .DIR-WN "\" is doing in that sentence." CR>
                  <TRACE-OUT>
                  <RFALSE>)>
           <SETG PRSO-DIR <>>)>
    ;"Match syntax lines and objects"
    <COND (<NOT .O-R>
           <TRACE 2 "[matching syntax and finding objects, KEEP=" N .KEEP "]" CR>
           <COND (<NOT <AND <MATCH-SYNTAX> <FIND-OBJECTS .KEEP>>>
                  <TRACE-OUT>
                  <SETG P-CONT 0>
                  <RFALSE>)>)
          (<L? .KEEP 2>
           ;"We already found a syntax line last time, but we need FIND-OBJECTS to
             match at least one noun phrase."
           <TRACE 2 "[only finding objects, KEEP=" N .KEEP "]" CR>
           <COND (<NOT <FIND-OBJECTS .KEEP>>
                  <TRACE-OUT>
                  <SETG P-CONT 0>
                  <RFALSE>)>)>
    ;"Save command for AGAIN"
    <COND (<NOT <VERB? AGAIN>>
           <TRACE 4 "[saving for AGAIN]" CR>
           <SAVE-PARSER-RESULT ,AGAIN-STORAGE>)>
    ;"If successful PRSO, back up PRSO for IT"
    <SET-PRONOUNS ,PRSO ,P-PRSOS>
    <TRACE-OUT>
    <RTRUE>>