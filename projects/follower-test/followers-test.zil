"follower demo MAIN FILE"

<VERSION XZIP>
<CONSTANT RELEASEID 1>
<CONSTANT GAME-BANNER "ZIL Follower Demo|A pathfinding NPC demonstration.">

<ROUTINE GO ()
 <TELL "Follower Demo Initialized." CR>
 <SETG HERE ,ROOM-1>
 <MOVE ,PLAYER ,HERE>
 <FOLLOW ,FOLLOWER-NPC ,PLAYER>
 <V-LOOK>
 <MAIN-LOOP>>
 
<INSERT-FILE "parser">
<INSERT-FILE "follower">


<OBJECT FOLLOWER-NPC
 (LOC ROOM-1)
 (FLAGS PERSONBIT)
 (DESC "a friendly NPC")
 (ACTION FOLLOWER-F)>

<ROUTINE FOLLOWER-F (ARG)
 <COND (<==? .ARG ,M-ENTER>
        <FOLLOW-TICK ,FOLLOWER-NPC>)>>

<ROOM ROOM-1 (DESC "Room 1") (EAST TO ROOM-2) (FLAGS LIGHTBIT)>
<ROOM ROOM-2 (DESC "Room 2") (WEST TO ROOM-1) (EAST TO ROOM-3) (FLAGS LIGHTBIT)>
<ROOM ROOM-3 (DESC "Room 3") (WEST TO ROOM-2) (FLAGS LIGHTBIT)>
