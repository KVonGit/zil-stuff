"Pathfinding Game Example"

<VERSION XZIP>
<CONSTANT RELEASEID 0>

<CONSTANT GAME-BANNER "Pathfinder|Example NPC follower using ZIL">

<INSERT-FILE "parser">
<INSERT-FILE "pathfinding">

<ROOM START (DESC "Start Room") (EAST TO HALLWAY)>
<ROOM HALLWAY (DESC "Hallway") (WEST TO START) (EAST TO CHAMBER)>
<ROOM CHAMBER (DESC "Chamber") (WEST TO HALLWAY)>

<OBJECT ZOMBIE
  (IN CHAMBER)
  (DESC "a shambling zombie")>

<ROUTINE GO ()
  <SETG HERE START>
  <MOVE ,PLAYER ,HERE>
  <MOVE ,ZOMBIE CHAMBER>
  <SETG FOLLOW-TARGET ,PLAYER>
  <V-LOOK>
  <MAIN-LOOP>>

<ROUTINE DAEMON ()
  <FOLLOW-TARGET-TICK>>

<SETG INITIAL-DAEMONS (DAEMON)>
