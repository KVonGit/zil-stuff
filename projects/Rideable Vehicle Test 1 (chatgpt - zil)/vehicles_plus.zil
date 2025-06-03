; vehicles_plus.zil

<SECTION VEHICLES>

"Enhanced vehicle support for ZILF games — automatic handling of mounting, dismounting, and vehicle-based travel."

<GLOBAL VEHICLE-LOC <> ; Holds current vehicle player is in/ on>

; Define MOUNT and DISMOUNT verbs
<SYNTAX MOUNT = V-MOUNT OBJECT>
<SYNTAX DISMOUNT = V-DISMOUNT>

<VERB MOUNT
  (SYNTAX V-MOUNT OBJECT)
  (ACTION V-MOUNT-F)>

<VERB DISMOUNT
  (SYNTAX V-DISMOUNT)
  (ACTION V-DISMOUNT-F)>

; Synonyms for mount and dismount
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
     <LOOK>)>)>

<ROUTINE V-DISMOUNT-F ()
  <COND
    (<NOT <IN? ,PLAYER ,VEHICLE-LOC>>
     <TELL "You're not riding anything." CR>
     <RETURN T>)
    (T
     <MOVE ,PLAYER <LOC ,VEHICLE-LOC>>
     <TELL "You dismount from " T ,VEHICLE-LOC "." CR>
     <SETG VEHICLE-LOC <>>
     <LOOK>)>)>

; Patch ENTER to redirect to MOUNT if VEHBIT
<ROUTINE ENTER-VEHICLE-HOOK ()
  <COND
    (<AND <FSET? ,PRSO ,VEHBIT> <NOT <==? ,PRSA ,MOUNT>>>
     <SETG PRSA ,MOUNT>
     <PERFORM ,PRSA ,PRSO>)>)

; Hook into ENTER pre-actions
<PRE-ACTION (ENTER-VEHICLE-HOOK)>

; Append vehicle description in LOOK
<ROUTINE DESCRIBE-VEHICLE ()
  <COND
    (<IN? ,PLAYER ,VEHICLE-LOC>
     <TELL " (on " T ,VEHICLE-LOC ")">)>)

; Patch room name description
<ROUTINE DESCRIBE-ROOM-NAME ()
  <TELL ,RNAME>
  <DESCRIBE-VEHICLE>
  <CRLF>>

; Add travel blocking if in vehicle without OPENBIT
<ROUTINE VEHICLE-SCOPE-CHECK ()
  <COND
    (<AND <FSET? ,VEHICLE-LOC ,VEHBIT>
          <NOT <FSET? ,VEHICLE-LOC ,OPENBIT>>>
     <TELL "You can't reach that from inside " T ,VEHICLE-LOC "." CR>
     <RETURN T>)>)>

; Hook into object scope check
<PRE-ACTION (VEHICLE-SCOPE-CHECK)>

<ENDSECTION>
