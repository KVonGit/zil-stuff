"Simple Pathfinding Library"

<GLOBAL FOLLOW-TARGET <>>
<GLOBAL PATH-TABLE <ITABLE 20>>
<GLOBAL PATH-LEN 0>
<GLOBAL PATH-IDX 0>

<ROUTINE FIND-PATH (START DEST "AUX" QUEUE QHEAD QTAIL VISITED IDX CURR NEXT REXITROOM)
  <SET QUEUE <ITABLE 50>>
  <SET VISITED <ITABLE 100>>
  <PUTB .QUEUE 0 .START>
  <PUTB .VISITED .START 255>
  <SET QHEAD 0>
  <SET QTAIL 1>
  <COND 
    (<==? .START .DEST> 
      <RETURN T>
    )
  >
  <REPEAT ()
    (<G=? .QHEAD .QTAIL>
     <RETURN <>>)
    <SET CURR <GETB .QUEUE .QHEAD>>
    <SET QHEAD <+ .QHEAD 1>>
    <MAP-DIRECTIONS (DIR PROP .CURR)
      (END <SET REXITROOM <GET .PROP ,REXIT>>)
      <COND 
        (<AND 
          <NOT <0? .REXITROOM>>
          <0? <GETB .VISITED .REXITROOM>>
        >
          <PUTB .QUEUE .QTAIL .REXITROOM>
          <SET QTAIL <+ .QTAIL 1>>
          <PUTB .VISITED .REXITROOM .CURR>
          <COND 
            (<==? .REXITROOM .DEST>
              <SET IDX 0>
              <SET CURR .DEST>
              <REPEAT ()
                (<==? .CURR .START>
                  <SETG PATH-LEN .IDX>
                  <SETG PATH-IDX 0>
                  <RETURN T>
                )
               <PUTB ,PATH-TABLE .IDX .CURR>
               <SET IDX <+ .IDX 1>>
               <SET CURR <GETB .VISITED .CURR>>
            )
          >
        )
      >
    <RETURN <>>>

<ROUTINE FOLLOW-TARGET-TICK ()
  <COND (<AND ,FOLLOW-TARGET
              <NOT <==? ,FOLLOW-TARGET ,HERE>>>
         <COND (<FIND-PATH ,HERE ,FOLLOW-TARGET>
                <SETG HERE <GETB ,PATH-TABLE 0>>
                <MOVE ,ZOMBIE ,HERE>
                <TELL "ZOMBIE shambles in from afar..." CR>)>)>>
