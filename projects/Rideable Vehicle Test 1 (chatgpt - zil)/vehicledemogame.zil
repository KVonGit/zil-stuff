;"by chatgpt"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<CONSTANT GAME-BANNER
  "Vehicle Demo Game|Rideable Vehicles in ZILF|Release 1">
  
<ROUTINE GO ()
  <TELL CR CR>
  <INIT-STATUS-LINE>
  <V-VERSION>
  <SETG HERE ,FIELD>
  <MOVE ,PLAYER ,HERE>
  <V-LOOK>
  <MAIN-LOOP>>

<INSERT-FILE "parser">
<SET REDEFINE T>
<INSERT-FILE "vehicles_plus">


<OBJECT FIELD
  (IN ROOMS)
  (DESC "Grassy Field")
  (LDESC "You are in a grassy field. A red tricycle and a rowboat are here.")
  (FLAGS LIGHTBIT)
  (EAST TO POND)>

<OBJECT POND
  (IN ROOMS)
  (DESC "Small Pond")
  (LDESC "You are beside a small pond."
         "The rowboat is bobbing near the edge.")
  (FLAGS LIGHTBIT)
  (WEST TO FIELD)>

<OBJECT TRICYCLE
  (DESC "red tricycle")
  (IN FIELD)
  (SYNONYM TRICYCLE BIKE)
  (ADJECTIVE RED)
  (FLAGS VEHBIT SURFACEBIT OPENBIT)
  (LDESC "A red tricycle stands here.")>

<OBJECT BOAT
  (DESC "rowboat")
  (IN FIELD)
  (SYNONYM BOAT ROWBOAT)
  (FLAGS VEHBIT CONTBIT OPENBIT LIGHTBIT)
  (LDESC "A small rowboat rests at the edge of the pond.")>

