;" vehicles_plus.zil (patched for ZILF compatibility, no PRE-ACTION)"

<GLOBAL VEHICLE-LOC <>>

<SYNTAX MOUNT OBJECT = V-MOUNT>
<SYNTAX DISMOUNT = V-DISMOUNT>

<ROUTINE V-MOUNT ()
  <V-MOUNT-F>>

<ROUTINE V-DISMOUNT ()
  <V-DISMOUNT-F>>

<ROUTINE V-ENTER ()
  <COND
    (<AND <FSET? ,PRSO ,VEHBIT>>
     <PERFORM ,V?MOUNT ,PRSO>)
    (T <RFALSE>)>>

<PREP-SYNONYM ON = IN>
<VERB-SYNONYM RIDE = MOUNT>
<VERB-SYNONYM GET-ON = MOUNT>
<VERB-SYNONYM GET-OFF = DISMOUNT>

<ROUTINE V-MOUNT-F ()
  <COND
    (<NOT <FSET? ,PRSO ,VEHBIT>>
     <TELL T ,PRSO " can't be ridden." CR>
     <RETURN T>)
    (<==? ,PRSO ,VEHICLE-LOC>
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
     <SETG VEHICLE-LOC ,PRSO>
     <TELL "You mount " T ,PRSO "." CR>
     <V-LOOK>)>>

<ROUTINE V-DISMOUNT-F ()
  <COND
    (<NOT <IN? ,PLAYER ,VEHICLE-LOC>>
     <TELL "You're not riding anything." CR>
     <RETURN T>)
    (T
     <MOVE ,PLAYER <LOC ,VEHICLE-LOC>>
     <TELL "You dismount from " T ,VEHICLE-LOC "." CR>
     <SETG VEHICLE-LOC <>>
     <V-LOOK>)>>

<ROUTINE DESCRIBE-VEHICLE ()
  <COND
    (<IN? ,PLAYER ,VEHICLE-LOC>
     <TELL " (on " T ,VEHICLE-LOC ")">)>>

; Developers may call VEHICLE-SCOPE-CHECK manually in actions if needed
<ROUTINE VEHICLE-SCOPE-CHECK ()
  <COND
    (<AND <FSET? ,VEHICLE-LOC ,VEHBIT>
          <NOT <FSET? ,VEHICLE-LOC ,OPENBIT>>>
     <TELL "You can't reach that from inside " T ,VEHICLE-LOC "." CR>
     <RETURN T>)>>
     
<ROUTINE DESCRIBE-ROOM (RM "OPT" LONG "AUX" P)
    <COND (<AND <==? .RM ,HERE> <NOT ,HERE-LIT>>
           <DARKNESS-F ,M-LOOK>
           <RFALSE>)>
    ;"Print the room's real name."
    <VERSION? (ZIP) (ELSE <HLIGHT ,H-BOLD>)>
    <TELL D .RM>
    <COND
      (<NOT ,VEHICLE-LOC>
        <TELL " (on the horse)">)>
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