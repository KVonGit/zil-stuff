- ZIL to play sound (I'm using XZIP for Z5, but ZIP for Z3 works just as well):

```zil
<VERSION XZIP>
<ZIP-OPTIONS SOUND>;"Gotta have this for it to work in Windows Frotz."
<CONSTANT RELEASEID 0>
<CONSTANT GAME-BANNER "PRESS THE BUTTON">

<INSERT-FILE "parser">

<ROUTINE GO ()
    <CRLF>
    <CRLF>
    <SETG MODE ,VERBOSE>
    <SETG HERE ,SOUND-BOOTH>
    <MOVE ,PLAYER ,HERE>
    <INIT-STATUS-LINE>
    <V-VERSION>
    <CRLF>
    <V-LOOK>
    <MAIN-LOOP>>

;"sound id"
<CONSTANT MESSAGE-ONE 3> ;" This will match the number in the blurb for this file."

<ROOM SOUND-BOOTH
  (IN ROOMS)
  (DESC "Sound Booth")
  (LDESC "You are in a small sound booth.")
  (FLAGS LIGHTBIT)
>

<OBJECT BUTTON
  (IN SOUND-BOOTH)
  (DESC "button")
  (FDESC "You see a button you can push!")
  (SYNONYM button)
  (FLAGS DEVICEBIT)
  (ACTION BUTTON-F)
>

<ROUTINE BUTTON-F ()
  <COND
    (<VERB? PUSH>
      <TELL "You hear a stupid message." CR>
      <SOUND ,MESSAGE-ONE 2 255> ;"This translates to <SOUND 3 2 255>, the 3 is the file ID, no idea what 2 is, and I think 255 is full volume?"
      <RTRUE>
    )
  >
>

```

---
- Compile with Zilf and Zapf

---
- create a blurb file like this one (substituting filenames) (this one is named 'audio-test.blurb'):

```
copyright "KV 2025"
release "0"
storyfile "audio-test.z5" include
sound 3 "Snd-3.ogg"
```

---
- (With Inform 7 installed) run this command from PowerShell (substitute filenames):

```ps
& 'C:\Program Files\Inform\Compilers\inblorb.exe' .\audio-test.blurb .\audio-test.zblorb
```

---
Now you have a .zblorb file with audio intact.

---
BONUS

- open https://iplayif.com/api/sitegen
- upload your .zblorb and click submit

Now you also have a website file which plays the game in Parchment, with working audio!
