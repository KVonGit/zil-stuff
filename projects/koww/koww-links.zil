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
      <TELL "<span obj=\"" .NM "-verbs-list-holder\">">
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
  <AND
    <==? ,SHOW-LINKS T>
    <TELL "<script>zilJs.currentRoom = \"" <GETP .RM ,P?PNAME> "\";</script>" CR>
  >
    <COND (<ORDERING?>
           <SET OWINNER ,WINNER>
           <RESET-WINNER>)>
    <SET WAS-LIT ,HERE-LIT>
    <SETG HERE .RM>
    <MOVE ,WINNER ,HERE>
    <APPLY <GETP .RM ,P?ACTION> ,M-ENTER>
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