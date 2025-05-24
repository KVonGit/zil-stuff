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


---
# FROM Learning_ZIL_by_Steven_Eric_Meretzky_1995

## Appendix B: Flags

Flags are the method for keeping track of the characteristics of an object or
room. The starting characteristics of an object are defined in the object's **FLAGS**
property. A flag can be set using `FSET`, cleared using `FCLEAR`, and checked
using `FSET`?

This is a list of flags which appear in many games. Additional flags can be added
to your game if you need them. There is a limit of 48 [right?] flags in **YZIP**.

---
### `TAKEBIT`
One of the most basic bits, this means that the player can pick up and
carry the object.

---
### `TRYTAKEBIT`
This bit tells the parser not to let the player implicitly take an
object, as in:

```
>READ DECREE
[taking the decree first]
```

This is important if the object has a value and must be scored, or if the object
has an `NDESCBIT` which must be cleared, or if you want taking the object to set
a flag or queue a routine, or...

---
### `CONTBIT`
The object is a container; things can be put inside it, it can be opened
and closed, etc.

---
### `DOORBIT`
The object is a door and various routines, such as `V-OPEN`, should
treat it as such.

---
### `OPENBIT`
The object is a door or container, and is open.

---
### `SURFACEBIT`
The object is a surface, such as a table, desk, countertop, etc.

Any object with the surfacebit should also have the `CONTBIT` (since you can put
things on the surface) and the `OPENBIT` (since you can't close a countertop as
you can a box).

---
### `LOCKEDBIT`
Tells routines like `V-OPEN` that an object or door is locked and
can't be opened without proper equipment.

---
### `WEARBIT`
The object can be worn. Given to garments and wearable equipment
such as jewelry or a diving helmet. Only means that the object is wearable, not
that it is actually being worn.

---
### `WORNBIT`
This means that a wearable object is currently being worn.

---
### `READBIT`
The object is readable. Any object with a `TEXT` property should have
the `READBIT`.

---
### `LIGHTBIT`
The object is capable of being turned on and off, like the old brass
lantern from Zork. However, it doesn't mean that the object is actually on.

---
### `ONBIT`
In the case of a room, this means that the room is lit. If your game takes
place during the day, any outdoor room should have the `ONBIT`. In the case of
an object, this means that the object is providing light. An object with the `ONBIT`
should also have the `LIGHTBIT`.

---
### `FLAMEBIT` [^2]
This means that the object is a source of fire. An object with the
`FLAMEBIT` should also have the `ONBIT` (since it is providing light) and the
`LIGHTBIT` (since it can be extinguished).

---
### `BURNBIT` [^2]
The object is burnable. Generally, most takeable objects which are
made out of wood or paper should have the `BURNBIT`.
Page 62 Learning ZIL 2/25/2002

---
### `TRANSBIT`
The object is transparent; objects inside it can be seen even if it is
closed.

---
### `NDESCBIT`
The object shouldn't be described by the describers. This usually
means that someone else, such as the room description, is describing the object.
Any takeable object, once taken, should have its `NDESCBIT` cleared.

---
### `INVISIBLE`
One of the few bits that doesn't end in "-BIT," `INVISIBLE` tells the
parser not to find this object. Usually, the intention is to clear the invisible at
some point. For example, you might clear the invisible bit on the `BLOOD-STAIN`
object after the player examines the bludgeon. Until that point, referring to the
blood stain would get a response like "You can't see any blood stain right here."

---
### `TOUCHBIT`
In the case of a room, this means that the player has been to the
room at least once. Obviously, no room should be defined with a `TOUCHBIT`,
since at the beginning of the game, the player has not been in any room yet. In
the case of an object, this means that the object has been taken or otherwise
disturbed by the player; for example, once the `TOUCHBIT` of an object is set, if it
has an `FDESC`, that `FDESC` will no longer be used to describe it.

---
### `SEARCHBIT` [^2]
A very slippery concept. It tells the parser to look as deeply into a
container as it can in order to find the referenced object. Without the
SEARCHBIT, the parser will only look down two-levels. Example. There's a box
on the ground; there's a bowl in the box; there's an apple in the bowl.

If the player says **TAKE APPLE**, and the box or the bowl have a `SEARCHBIT`,
the apple will be found by the parser and then taken. If the player says **TAKE**
**APPLE**, and the box and bowl don't have the `SEARCHBIT`, the parser will say
"You can't see any apple right here." Frankly, I think the `SEARCHBIT` is a stupid
concept, and I automatically give the `SEARCHBIT` to all containers.

---
### `VEHBIT` [^2]
This means that the object is a vehicle, and can be entered or boarded
by the player. All objects with the `VEHBIT` should usually have the `CONTBIT` and
the OPENBIT.

---
### `PERSONBIT`
This means that the object is a character in the game, and such
act accordingly. For example, they can be spoken to. This flag is sometimes
called the `ACTORBIT`.

---
### `FEMALEBIT`
The object is an **ACTOR** who is a female. Informs various routines
to say "she" instead of "he."

---
### `VOWELBIT`
The object's `DESC` begins with a vowel; any verb default which
prints an indefinite article before the `DESC` is warned to use "an" instead of "a."

---
### `NARTICLEBIT`
The object's `DESC` doesn't not work with articles, and they
should be omitted. An example is the `ME` object, which usually has the `DESC`
"you." A verb default should say "It smells just like you." rather than "It smells just
like a you."

---
### `PLURALBIT`
The object's `DESC` is a plural noun or noun phrase, such as
"barking dogs," and routines which use the `DESC` should act accordingly.

---
### `RLANDBIT` [^2]
Usually used only for rooms, this bit lets any routine that cares know
that the room is dry land (as most are).

---
### `RWATERBIT` [^2]
The room is water rather than dry land, such as the River and
Reservoir in Zork I. Some typical implications: The player can't go there without a
boat; anyone dropped outside of the boat will sink and be lost, etc.

Page 63 Learning ZIL 2/25/2002

---
### `RAIRBIT` [^2]
The room is in mid-air, for those games with some type of flying.

---
### `KLUDGEBIT`
This bit is used only in the syntax file. It is used for those syntaxes
which want to be simply **VERB PREPOSITION** with no object. Put `(FIND
KLUDGEBIT)` after the object. The parser, rather than complaining about the
missing noun, will see the `FIND KLUDGEBIT` and set the `PRSO` (or `PRSI` as the
case may be) to the `ROOMS` object. Some games use `RLANDBIT` instead of the
`KLUDGEBIT`; this saves a bit, since the parser won't "find" a room, and no
objects have the `RLANDBIT`.

---
### `OUTSIDEBIT` [^2]
Used in rooms to classify the room as an outdoors room.

---
### `INTEGRALBIT` [^2]
This means that the object is an integral part of some other
object, and can't be independently taken or dropped. An example might be a dial
or button on a (takeable) piece of equipment.

---
### `PARTBIT` [^2]
The object is a body part: the `HANDS` object, for example.

---
### `NALLBIT` [^2]
This has something to do with telling a **TAKE ALL** not to take
something, but I don't recall how it works. Help???

---
### `DROPBIT` [^2]
Found in vehicles, this not-very-important flag means that if the player
drops something while in that vehicle, the object should stay in the vehicle rather
than falling to the floor of the room itself.

---
### `INBIT` [^2]
Another not-too-important vehicle-related flag, it tells various routines to
say "in the vehicle" rather than "on the vehicle."

[^2]: Not in ZILF's `KNOWN-FLAGS`
