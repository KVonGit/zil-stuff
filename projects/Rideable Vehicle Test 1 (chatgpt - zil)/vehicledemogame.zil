; vehicle_demo.zil

<INSERT-FILE "parser">
<INSERT-FILE "vehicles_plus">

<VERSION ZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
  "Vehicle Demo Game|Rideable Vehicles in ZILF|Release 1">

<OBJECT ROOMS>
<ROOM FIELD
  (DESC "Grassy Field")
  (LDESC "You are in a grassy field. A red tricycle and a rowboat are here.")
  (FLAGS RLANDBIT ONBIT)
  (EAST TO POND)>

<ROOM POND
  (DESC "Small Pond")
  (LDESC "You are beside a small pond."
         "The rowboat is bobbing near the edge.")
  (FLAGS RWATERBIT ONBIT)
  (WEST TO FIELD)>

<OBJECT TRICYCLE
  (DESC "red tricycle")
  (IN FIELD)
  (SYNONYM TRICYCLE BIKE)
  (ADJECTIVE RED)
  (FLAGS VEHBIT SURFACEBIT ENTERBIT)
  (LDESC "A red tricycle stands here.")>

<OBJECT BOAT
  (DESC "rowboat")
  (IN FIELD)
  (SYNONYM BOAT ROWBOAT)
  (FLAGS VEHBIT CONTBIT OPENBIT ENTERBIT)
  (LDESC "A small rowboat rests at the edge of the pond.")>

<OBJECT PLAYER
  (IN FIELD)
  (DESC "yourself")
  (FLAGS PERSONBIT ACTORBIT)> ; Actor marker

<ROUTINE GO ()
  <TELL CR CR>
  <INIT-STATUS-LINE>
  <V-VERSION>
  <SETG HERE ,FIELD>
  <MOVE ,PLAYER ,HERE>
  <V-LOOK>
  <MAIN-LOOP>>
