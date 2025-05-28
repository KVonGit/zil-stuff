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
           <SETG HERE <LOC ,WINNER>>
           <SETG HERE-LIT <SEARCH-FOR-LIGHT>>
           <READLINE T>)>

    <IF-DEBUG <SETG TRACE-INDENT 0>>
    <TRACE-DO 1 <DUMPBUFS> ;<DUMPLINE>>
    <TRACE-IN>

    <SETG P-LEN <GETB ,LEXBUF 1>>
    <COND (<0? ,P-LEN>
           <TELL "..." CR>
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
                      <TELL "I don't know the word '" WORD .I "'." CR>
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


<ROUTINE MATCH-NOUN-PHRASE (NP OUT BITS "AUX" F NY NN SPEC MODE NOUT OBITS ONOUT BEST Q)
    <SET NY <NP-YCNT .NP>>
    <SET NN <NP-NCNT .NP>>
    <SET MODE <NP-MODE .NP>>
    <SET OBITS .BITS>
    <COND (<0? .MODE>
           <SET .BITS <ORB .BITS ;"<ORB" ,SF-HELD ,SF-CARRIED ,SF-ON-GROUND ,SF-IN-ROOM ;">" >>)>
    <TRACE 3 "[MATCH-NOUN-PHRASE: NY=" N .NY " NN=" N .NN " MODE=" N .MODE
             " BITS=" N .BITS " OBITS=" N .OBITS "]" CR>
    <TRACE-IN>
    <PROG BITS-SET ()
        ;"Look for matching objects"
        <SET NOUT 0>
        <COND (<0? .NY>
               ;"ALL with no YSPECs matches all objects, or if the action is TAKE/DROP,
                 all objects with TAKEBIT/TRYTAKEBIT, skipping generic/global objects."
               <TRACE 4 "[applying ALL rules]" CR>
               <MAP-SCOPE (I [BITS .BITS])
                   <COND (<SCOPE-STAGE? GENERIC GLOBALS>)
                         (<NOT <ALL-INCLUDES? .I>>)
                         (<AND .NN <NP-EXCLUDES? .NP .I>>)
                         (<G=? .NOUT ,P-MAX-OBJECTS>
                          <TELL "[too many objects!]" CR>
                          <TRACE-OUT>
                          <RETURN>)
                         (ELSE
                          <SET NOUT <+ .NOUT 1>>
                          <PUT/B .OUT .NOUT .I>)>>)
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
                       <COND (<AND <NOT <FSET? .I ,INVISIBLE>>
                                   <SET Q <REFERS? .SPEC .I>>
                                   <G=? .Q .BEST>>
                              <TRACE 4 "[matches " T .I "(" N .I "), Q=" N .Q "]" CR>
                              <SET F T>
                              ;"Erase previous matches if this is better"
                              <COND (<G? .Q .BEST>
                                     <TRACE 4 "[clearing match list]" CR>
                                     <SET NOUT .ONOUT>
                                     <SET .BEST .Q>)>
                              <COND (<AND .NN <NP-EXCLUDES? .NP .I>>
                                     <TRACE 4 "[excluded]" CR>)
                                    (<G=? .NOUT ,P-MAX-OBJECTS>
                                     <TELL "[too many objects!]" CR>
                                     <TRACE-OUT>
                                     <RETURN>)
                                    (ELSE
                                     <TRACE 4 "[accepted]" CR>
                                     <SET NOUT <+ .NOUT 1>>
                                     <PUT/B .OUT .NOUT .I>)>)>>
                   ;"Look for a pseudo-object if we didn't find a real one."
                   <COND (<AND <NOT .F>
                               <BTST .BITS ,SF-ON-GROUND>
                               <SET Q <GETP ,HERE ,P?THINGS>>>
                          <TRACE 4 "[looking for pseudo]" CR>
                          <SET F <MATCH-PSEUDO .SPEC .Q>>
                          <COND (.F
                                 <COND (<AND .NN <NP-EXCLUDES-PSEUDO? .NP .F>>)
                                       (<G=? .NOUT ,P-MAX-OBJECTS>
                                        <TELL "[too many objects!]" CR>
                                        <TRACE-OUT>
                                        <RETURN>)
                                       (ELSE
                                        <SET NOUT <+ .NOUT 1>>
                                        <PUT/B .OUT .NOUT <MAKE-PSEUDO .F>>)>)>)>
                   <COND (<NOT .F>
                          ;"Try expanding the search if we can."
                          <COND (<N=? .BITS -1>
                                 <TRACE 4 "[expanding to ludicrous scope]" CR>
                                 <SET BITS -1>
                                 <SET OBITS -1>    ;"Avoid bouncing between <1 and >1 matches"
                                 <AGAIN .BITS-SET>)>
                          <COND (<=? ,MAP-SCOPE-STATUS ,MS-NO-LIGHT>
                                 <TELL "It's too dark to see anything here." CR>)
                                (ELSE
                                 <COND
                                  (<VERB? SMELL>
                                    <TELL "You don't smell that here." CR>)
                                  (T
                                    <TELL "You don't see that here." CR>)>)>
                          <TRACE-OUT>
                          <RFALSE>)
                         (<G=? .NOUT ,P-MAX-OBJECTS>
                          <TRACE-OUT>
                          <RETURN>)>>)>
        ;"Check the number of objects"
        <PUTB .OUT 0 .NOUT>
        <COND (<0? .NOUT>
               ;"This means ALL matched nothing, or BUT excluded everything.
                 Try expanding the search if we can."
               <SET F <ORB .BITS ;"<ORB" ,SF-HELD ,SF-CARRIED ,SF-ON-GROUND ,SF-IN-ROOM ;">" >>
               <COND (<=? .BITS .F>
                      <TELL "There are none at all available!" CR>
                      <TRACE-OUT>
                      <RFALSE>)>
               <TRACE 4 "[expanding to reasonable scope]" CR>
               <SET BITS .F>
               <SET OBITS .F>    ;"Avoid bouncing between <1 and >1 matches"
               <AGAIN .BITS-SET>)
              (<1? .NOUT>
               <TRACE-OUT>
               <RETURN <GET/B .OUT 1>>)
              (<OR <=? .MODE ,MCM-ALL> <G? .NY 1>>
               <TRACE-OUT>
               <RETURN ,MANY-OBJECTS>)
              (<=? .MODE ,MCM-ANY>
               ;"Pick a random object"
               <PUT/B .OUT 1 <SET F <GET/B .OUT <RANDOM .NOUT>>>>
               <PUTB .OUT 0 1>
               <TELL "[" T .F "]" CR>
               <TRACE-OUT>
               <RETURN .F>)
              (ELSE
               ;"TODO: Do this check when we're matching YSPECs, so each YSPEC can be
                 disambiguated individually."
               ;"Try narrowing the search if we can."
               <COND (<N=? .BITS .OBITS>
                      <TRACE 4 "[narrowing scope to BITS=" N .OBITS "]" CR>
                      <SET BITS .OBITS>
                      <AGAIN .BITS-SET>)>
               <COND (<SET F <APPLY-GENERIC-FCN .OUT>>
                      <TRACE 4 "[GENERIC chose " T .F "]" CR>
                      <PUT/B .OUT 1 .F>
                      <PUTB .OUT 0 1>
                      <TRACE-OUT>
                      <RETURN .F>)>
               <WHICH-DO-YOU-MEAN .OUT>
               <COND (<=? .NP ,P-NP-DOBJ> <ORPHAN T AMBIGUOUS PRSO>)
                     (ELSE <ORPHAN T AMBIGUOUS PRSI>)>
               <TRACE-OUT>
               <RFALSE>)>>>