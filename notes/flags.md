# Flags

Table of Flags

| BIT | Description | Quest 5 Counterpart |
|--|--|--|
| `TAKEBIT` | Can be taken. | `take` |
| `NARTICLEBIT` | Omit article when printing object name | `nodefaultprefix` |
| `VOWELBIT` | Object name begins with a vowel; use 'an' as indefinite article. | NOT_NECESSARY |
| `NDESCBIT` | The object is scenery. | `scenery` |
| `LIGHTBIT` | All rooms need either this or `DARKBIT` | `room.dark = false` |
| `ONBIT` |||
| `DARKBIT` | The room is dark. | `dark` |
| `CONTBIT` | Object is a container. | container type |
| `TRANSBIT` | Object is transparent. | `transparent` |
| `INVISIBLE` | Object is not in play. | `object.visible = false` |
| `OPENABLEBIT` | Object is openable. | openable type |
| `LOCKEDBIT` |||
| `OPENBIT` |||
| `SURFACEBIT` |||
| `WEARBIT` |||
| `WORNBIT` |||
| `READBIT` |||
| `NALLBIT` | DOES NOT SEEM TO WORK[^1] | `notall` |
| `TRYTAKEBIT` | Do not implicitly take. | NO_COUNTERPART?|
| `PLURALBIT` | Object is plural; they or them. | pluralnamed type |
| `PERSONBIT` | Object is a person. (Default is MALE.) | npctype |
| `FEMALEBIT` | She's a lady. (Yeah, yeah, yeah... She's a lady.) | femalenamed type |
| `TOUCHBIT` | Object has been handled, or room has been visited. | `hasbeenmoved`(?) or `visited` |

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