"LINKS file for The Adventures of Koww the Magician"

<GLOBAL SHOW-LINKS <>>

<ROUTINE OBJECT-LINK (NM "OPT" AL)
  <AND
    <NOT <ASSIGNED? AL>>
    <SET AL .NM>
  >
  <COND
    (<==? ,SHOW-LINKS T>
      <TELL "<span class=\"object-link dropdown\" data-objname=\"" .NM "\"><span onclick=\"itemLinks.itemClick(this, event)\" obj=\"" .NM "\" class=\"droplink\">" .AL "</span><span obj=\"" .NM "\" class=\"dropdown-content\"><span obj=\"" .NM "-verbs-list-holder\"><a href=\"#\" onclick=\"sendCmd('examine " .AL "')\">examine</a><br><a href=\"#\" onclick=\"sendCmd('take " .AL "')\">take</a></span></span></span>">
      
    )
    (T
      <BOLDIZE .AL>
    )
  >
>

<ROUTINE NPC-LINK (NM "OPT" AL)
  <AND
    <NOT <ASSIGNED? AL>>
    <SET AL .NM>
  >
  <COND
    (<==? ,SHOW-LINKS T>
      <TELL "<span class=\"object-link dropdown\" data-objname=\"" .NM "\"><span onclick=\"itemLinks.itemClick(this, event)\" obj=\"" .NM "\" class=\"droplink\">" .AL "</span><span obj=\"" .NM "\" class=\"dropdown-content\"><span obj=\"" .NM "-verbs-list-holder\"><a href=\"#\" onclick=\"sendCmd('examine " .AL "')\">examine</a><br><a href=\"#\" onclick=\"sendCmd('talk to " .AL "')\">talk to</a></span></span></span>">
    )
    (T
      <BOLDIZE .AL>
    )
  >
>

<ROUTINE EXIT-LINK (TXT "OPT" DISPLAYTXT)
  <AND <NOT <ASSIGNED? DISPLAYTXT>><SET DISPLAYTXT .TXT>>
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
    <TELL "<script>yonk.currentRoom = \"" <GETP .RM ,P?PNAME> "\";</script>" CR>
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