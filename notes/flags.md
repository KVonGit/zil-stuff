# Flags

| BIT | Description | Quest 5 Counterpart |
|--|--|--|
| `ATTACKBIT` | ??? | ??? |
| `CONTBIT` | Object is a container. | container type |
| `DARKBIT` | Does not seem to work. Use `LIGHTBIT` and `FCLEAR` to remove `LIGHTBIT` | `dark` |
| `DEVICEBIT` | Object can be turn on or off. | switchable type|
| `DOORBIT` | Object is a door. | no counterpart |
| `EDIBLEBIT` | Object can be eaten. | 'eat' verb|
| `FEMALEBIT` | She's a lady. (Yeah, yeah, yeah... She's a lady.) | femalenamed type |
| `INVISIBLE` | Object is not in play. | `object.visible = false` |
| `KLUDGEBIT` | ??? | ??? |
| `LIGHTBIT` | All rooms need either this or `DARKBIT` | `room.dark = false` |
| `LOCKEDBIT` | Object is locked. | `locked` |
| `NALLBIT` | DOES NOT SEEM TO WORK [^1] | `notall` |
| `NARTICLEBIT` | Omit article when printing object name | `nodefaultprefix` |
| `NDESCBIT` | The object is scenery. | `scenery` |
| `ONBIT` | Object is currently on. | `switchedon` |
| `OPENABLEBIT` | Object is openable. | openable type |
| `OPENBIT` | Object is open. | `isopen` |
| `PERSONBIT` | Object is a person. (Default is MALE.) | npctype |
| `PLURALBIT` | Object is plural; they or them. | pluralnamed type |
| `READBIT` | Object can be read (use TEXT attribute). | 'read' verb |
| `SCENERYBIT` | Does not work in ZILF. See `NDESCBIT` | `scenery` |
| `SURFACEBIT` | Object is a surface. | surface type |
| `TAKEBIT` | Can be taken. | `take` |
| `TOOLBIT` | ??? | ??? |
| `TOUCHBIT` | Object has been handled, or room has been visited. | `hasbeenmoved`(?) or `visited` |
| `TRANSBIT` | Object is transparent. | `transparent` |
| `TRYTAKEBIT` | Do not implicitly take. | NO_COUNTERPART?|
| `VOWELBIT` | Object name begins with a vowel; use 'an' as indefinite article. | NOT_NECESSARY |
| `WEARBIT` | Object can be worn. | clothing type???|
| `WORNBIT` | Object is currently worn. | `IsWorn()`??? |


MORE TO COME!

[^1]: I am currently using `NDESCBIT` on these objects and adding them to the room description, then using `FCLEAR` to remove the `NDESCBIT` on take.

---
### FROM "parser.zil":

```zil
;"These are all set on ROOMS in case no game objects define them."
;"TODO: Eliminate some standard flags or make them optional.
  27 flags in the library only leaves 5 for V3 games."
<SETG KNOWN-FLAGS
    (ATTACKBIT CONTBIT DEVICEBIT DOORBIT EDIBLEBIT FEMALEBIT INVISIBLE KLUDGEBIT
     LIGHTBIT LOCKEDBIT NARTICLEBIT NDESCBIT ONBIT OPENABLEBIT OPENBIT PERSONBIT
     PLURALBIT READBIT SURFACEBIT TAKEBIT TOOLBIT TOUCHBIT TRANSBIT TRYTAKEBIT
     VOWELBIT WEARBIT WORNBIT
     !,EXTRA-FLAGS)>
```