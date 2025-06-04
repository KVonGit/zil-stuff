;"CHEST-TEST.ZIL"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
  "||Chest Test Game|This is only a test.|">
  
<ROUTINE GO ()
  <TELL CR CR>
  <INIT-STATUS-LINE>
  <V-VERSION>
  <SETG HERE ,TESTING-CENTER>
  <MOVE ,PLAYER ,HERE>
  <V-LOOK>
  <MAIN-LOOP>>

<INSERT-FILE "parser">

<OBJECT TESTING-CENTER
  (IN ROOMS)
  (DESC "Testing Room A")
  (LDESC "A small, white room, designed only for testing.")
  (FLAGS LIGHTBIT)
  (ACTION TESTING-CENTER-R)>

;---------------------------------------------------------------------------------------------------
"TESTING-CENTER-R is unnecessary. Just overriding “That was a rhetorical question.” responses."
;---------------------------------------------------------------------------------------------------

<ROUTINE TESTING-CENTER-R ()
  <COND
    (<VERB? YES>
      <TELL "You sound very positive!" CR>
      <RTRUE>)
    (<VERB? NO>
      <TELL "You sound rather negative." CR>
      <RTRUE>)>>

<OBJECT CHEST
    (DESC "chest")
    (SYNONYM CHEST)
    (IN TESTING-CENTER)
    (FLAGS CONTBIT OPENABLEBIT)
    (ACTION CHEST-R)>

<ROUTINE CHEST-R ()
    <COND
      (<VERB? EXAMINE>
        <TELL "It's just a chest, with no lock. It is currently ">
        <COND
          (<FSET? ,CHEST ,OPENBIT>
            <TELL "open">)
          (T
            <TELL "closed">)>
        <TELL "." CR>)
      (<VERB? TAKE>
        <TELL "" CR>)
      (<VERB? UNLOCK LOCK>
        <TELL "It has no lock, and you have no key." CR>)>>

<OBJECT NOTE
  (IN CHEST)
  (FLAGS TAKEBIT READBIT)
  (DESC "note")
  (TEXT "It reads: If you can read this, the test was successful.")
  (SYNONYM NOTE LETTER WORD WORDS PAPER WRITIN WRITING TEXT)
  (ACTION NOTE-R)>

<ROUTINE NOTE-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "About what you'd expect, it's made of paper and has words written on it." CR>)>>


;---------------------------------------------------------------------------------------------------
" The following is unnecessary. All that is required for this is test is above this line."
;---------------------------------------------------------------------------------------------------

<OBJECT LOCK
    (DESC "no lock")
    (SYNONYM LOCK)
    (ADJECTIVE NO)
    (IN GLOBAL-OBJECTS)
    (FLAGS NDESCBIT NARTICLEBIT)
    (ACTION LOCK-R)>

<ROUTINE LOCK-R ()
    <COND
      (<VERB? EXAMINE>
        <TELL "The chest has no lock." CR>)
      (<VERB? TAKE>
        <TELL "You can't take a lock that doesn't exist!" CR >)
      (<VERB? OPEN CLOSE>
        <TELL "There is no lock. (Are you sure you're old enough to play a text adventure?)" CR>)
      (<VERB? LOCK UNLOCK>
        <TELL "You have no key, and there is no lock!" CR>)>>


<OBJECT KEY
  (IN PLAYER)
  (DESC "no key")
  (SYNONYM KEY)
  (ADJECTIVE NO)
  (FLAGS NARTICLEBIT)
  (ACTION KEY-R)>

<ROUTINE KEY-R ()
  <COND
    (<VERB? EXAMINE>
      <TELL "What key?" CR>)
    (<VERB? TAKE>
      <TELL "no key: Taken." CR>)
    (<VERB? DROP>
      <TELL "You are already holding no key!" CR>)>>