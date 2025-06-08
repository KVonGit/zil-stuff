"Drumsticks main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main Loop"

<CONSTANT GAME-BANNER "Drumsticks|An interactive fiction by Luke A. Jones">

<ROUTINE GO ()
    <CRLF>
    <CRLF>
    <TELL 
"You have just eaten a huge breakfast fry-up, including a couple of rather gristly sausages. The
grease sits heavy in your stomach.||You are contemplating what to do today, when in bursts Robin
Lye, the local music promoter. He dashes over to you, panting for breath, and says, 'you still
managing that band? The Bony Kings?'||You nod. 'Yep. For my sins.'||'Well, then,' says Robin.
'We might be able to do each other a favour. I need a support band for tonight. I've got Get Lamp
booked in to play the Blackfriar's Inn, and the support have dropped out. The gig is sold out. There
is a grand in the hand for you and the band if you can fill the slot. What do you say?'
||You pause for a moment. The water bill you opened this morning flashes through your mind, and you
say, 'alright. I'll get the band and equipment together.'||'Nice one,' says Robin. 'Soundcheck is at
5pm, don't be late. I'm off. Oh... Hi, Jon.'||Jon nods but continues chewing the last of his fried
egg sandwich.||'Right, see you later,' says Robin and dashes out of the café. A few seconds later,
he pops his head around the door again and says, 'oh, do me a favour and find me a DJ to warm the
crowd up before the support.' You give him a thumbs up, and he dashes off again.||'Right,' you say
to Jonny. 'We need to get the band together, find a DJ, pick up the equipment from the rehearsal
rooms with the van and get over to the Blackfriar's Inn.'||'OK, Boss,' says Jonny, 'but er... there
is one small problem. The van is fucked.'" CR CR>
    <V-VERSION>
    <CRLF>
    <SETG HERE ,GREASY-SPOON-CAFE>
    <MOVE ,PLAYER ,HERE>
    <V-LOOK>
    <REPEAT ()
      <COND
        (<PARSER>
          <PERFORM ,PRSA ,PRSO ,PRSI>
          <COND
            (<NOT <GAME-VERB?>>
              <APPLY <GETP ,HERE ,P?ACTION> ,M-END>
              <CLOCKER>)>)>
      <SETG HERE <LOC ,WINNER>>>>

<INSERT-FILE "parser">

"Rooms"

<ROOM GREASY-SPOON-CAFE
    (DESC "The Greasy Spoon Café")
    (LDESC
"The Greasy Spoon Café is a temple of fried pork products and eggs. The food is cheap and filthy
gorgeous. The room contains rickety chairs and tables with wipe-clean plastic tablecloths. Although
when they were last wiped is a mystery lost in the depths of time.")
    (IN ROOMS)
    (OUT TO OUTSIDE-THE-GREASY-SPOON-CAFE)
    (FLAGS LIGHTBIT)>


<ROOM BEHIND-THE-GREASY-SPOON-CAFE
    (DESC "Behind the Greasy Spoon Café")
    (LDESC 
"The back yard of the Greasy Spoon Café. A hard-standing area of concrete with wheelie bins lined up
on one side. There is a back door into the café on the north side.")
    (IN ROOMS)
    (NE TO TRINITY-LANE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-THE-GREASY-SPOON-CAFE
    (DESC "Outside the Greasy Spoon Café")
    (IN ROOMS)
    (NORTH TO OXFORD-ROAD)
    (IN TO GREASY-SPOON-CAFE)
    (FLAGS LIGHTBIT)>


<ROOM OXFORD-ROAD
    (DESC "Oxford Road")
    (LDESC
"The main arterial road for the town. To the North is Brunswick street, to the East is the Town
Square, Blackfriars Road lies to the west, and to the South is the Greasy Spoon Café.||There is a
constant rumble of traffic passing.")
    (IN ROOMS)
    (NORTH TO BRUNSWICK-STREET)
    (SOUTH TO OUTSIDE-THE-GREASY-SPOON-CAFE)
    (EAST TO TOWN-SQUARE)
    (WEST TO BLACKFRIARS-ROAD)
    (FLAGS LIGHTBIT)>


<ROOM BRUNSWICK-STREET
    (DESC "Brunswick Street")
    (LDESC
"A narrow meandering medieval backstreet.")
    (IN ROOMS)
    (NORTH TO OUTSIDE-MAC-ATTACKS-HOUSE)
    (SOUTH TO OXFORD-ROAD)
    (NE TO OUTSIDE-THE-NO-SMOKE-INN)
    (UP TO TOP-OF-THE-TREE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-MAC-ATTACKS-HOUSE
    (DESC "Outside Mac Attack's House")
    (IN ROOMS)
    (SOUTH TO BRUNSWICK-STREET)
    (IN TO MAC-ATTACKS-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM MAC-ATTACKS-HOUSE
    (DESC "Mac Attack's House")
    (LDESC
"Mac's house is a shrine to the two loves of his life; drums and computer games. The room is
dominated by an 80 inch plasma widescreen TV and a sound system that would put the local IMAX
theatre to shame.||In the corner of the room is an electronic drum kit and on the walls are posters
of Mac's drum heroes; John Bonham, Neil Peart, Mike Portnoy, Keith Moon etc. Mac is glued to the TV
playing Dark Souls III, it looks like he hasn't slept properly in days.")
    (IN ROOMS)
    (OUT TO OUTSIDE-MAC-ATTACKS-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-THE-NO-SMOKE-INN
    (DESC "Outside the No Smoke Inn")
    (IN ROOMS)
    (SW TO BRUNSWICK-STREET)
    (IN TO THE-NO-SMOKE-INN)
    (FLAGS LIGHTBIT)>


<ROOM THE-NO-SMOKE-INN
    (DESC "The No Smoke Inn")
    (LDESC
"Recently opened, the No Smoke Inn sells vaping equipment and liquids. Displayed in glass cabinets
are complicated looking vaping machines with various tubes, tanks and charging systems. On the walls
are posters advertising bizarre and baffling flavours, 'Baked Beans on Toast', 'Dinner Lady
(the old school taste of rice pudding!)', 'Ocean Lime', 'Cornflake Tart', 'Twisted Ice-cream'.")
    (IN ROOMS)
    (OUT TO OUTSIDE-THE-NO-SMOKE-INN)
    (FLAGS LIGHTBIT)>


<ROOM TOP-OF-THE-TREE
    (DESC "The Top of the Tree")
    (LDESC
"A large oak tree. The last surviving one on this road after the council conducted some overzealous
pruning.")
    (IN ROOMS)
    (DOWN TO BRUNSWICK-STREET)
    (FLAGS LIGHTBIT)>


<ROOM TOWN-SQUARE
    (DESC "Town Square")
    (LDESC
"The main town square. At Christmas time there is a market here, but today it is empty.")
    (IN ROOMS)
    (NORTH TO OUTSIDE-JUNK-N-DISORDERLY)
    (SOUTH TO TRINITY-LANE)
    (EAST TO INDUSTRIAL-ESTATE)
    (WEST TO OXFORD-ROAD)
    (SW TO OUTSIDE-DISCOVERY-RECORDS)
    (FLAGS LIGHTBIT)>


<ROOM INDUSTRIAL-ESTATE
    (DESC "Industrial Estate")
    (IN ROOMS)
    (NORTH TO OUTSIDE-PMT-MUSIC-SUPPLIES)
    (SOUTH TO OUTSIDE-ED-KAYCES-HOUSE)
    (EAST TO VERNON-MILL-REHEARSAL-ROOMS)
    (WEST TO TOWN-SQUARE)
    (SE TO OUTSIDE-SCRAP-YARD)
    (FLAGS LIGHTBIT)>


<ROOM VERNON-MILL-REHEARSAL-ROOMS
    (DESC "Vernon Mill Rehearsal Rooms")
    (LDESC
"A 19th century cotton mill, now home to artist studios, a martial arts club and band rehearsal
rooms (including your band's room).")
    (IN ROOMS)
    (WEST TO INDUSTRIAL-ESTATE)
    (UP TO BANDS-REHEARSAL-ROOM)
    (FLAGS LIGHTBIT)>


<ROOM BANDS-REHEARSAL-ROOM
    (DESC "Band's Rehearsal Room")
    (IN ROOMS)
    (DOWN TO VERNON-MILL-REHEARSAL-ROOMS)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-JUNK-N-DISORDERLY
    (DESC "Outside the Junk 'n' Disorderly")
    (IN ROOMS)
    (SOUTH TO TOWN-SQUARE)
    (IN TO JUNK-N-DISORDERLY-SHOP)
    (FLAGS LIGHTBIT)>


<ROOM JUNK-N-DISORDERLY-SHOP
    (DESC "Junk 'n' Disorderly Shop")
    (LDESC
"A second-hand shop run by Matt Roach. The rumour is that Matt is actually a serial hoarder, and the
shop is just a cover so that the council don't evict him. Judging by the state of shop you can well
believe the rumours. Every piece of wall and most of the floor space is piled high with clutter,
kipple, and junk.")
    (IN ROOMS)
    (OUT TO OUTSIDE-JUNK-N-DISORDERLY)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-PMT-MUSIC-SUPPLIES
    (DESC "Outside PMT Music Supplies")
    (IN ROOMS)
    (SOUTH TO INDUSTRIAL-ESTATE)
    (IN TO PMT-MUSIC-SUPPLIES)
    (FLAGS LIGHTBIT)>


<ROOM PMT-MUSIC-SUPPLIES
    (DESC "PMT Music Supplies")
    (LDESC
"Professional Music Technology (PMT) store. One of the biggest music equipment stores in the
country.||It's best not to linger here to long unless you want to hear the opening riff of \"Sweet
Child O' Mine\" played over and over again, incorrectly.||You can currently hear someone playing
\"Smoke on the Water\" on a bass guitar at half tempo.||You only come in here because the basement
houses an excellent repair shop: Buzz Stop.")
    (IN ROOMS)
    (DOWN TO BUZZ-STOP)
    (OUT TO OUTSIDE-PMT-MUSIC-SUPPLIES)
    (FLAGS LIGHTBIT)>


<ROOM BUZZ-STOP
    (DESC "Buzz Stop")
    (LDESC
"Guitar and bass repair shop, run by Helen Key. Helen is a wizard at repairs and people come from
miles around for her services. On the workbench in the middle of the room and hanging on the walls
are tools, boxes of parts, and guitars in a variety of different states of dismantlement and
repair.")
    (IN ROOMS)
    (UP TO PMT-MUSIC-SUPPLIES)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-SCRAP-YARD
    (DESC "Outside Scrap Yard")
    (IN ROOMS)
    (NW TO INDUSTRIAL-ESTATE)
    (IN TO SCRAP-YARD)
    (FLAGS LIGHTBIT)>


<ROOM SCRAP-YARD
    (DESC "Scrap Yard")
    (LDESC
"An old school breakers yard that has been here for decades. Wrecks of cars and vans in various
stages of decay are stacked up in piles in the yard. The ground is filthy and polluted with years of
oil, fuel and other automotive fluid spillages. The place is run by Roy Jackson and his daughter
Sarah.")
    (IN ROOMS)
    (OUT TO OUTSIDE-SCRAP-YARD)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-ED-KAYCES-HOUSE
    (DESC "Outside Ed Kayce's House")
    (IN ROOMS)
    (NORTH TO INDUSTRIAL-ESTATE)
    (WEST TO TRINITY-LANE)
    (FLAGS LIGHTBIT)>

<ROOM ED-KAYCES-HOUSE
    (DESC "Ed Kayce's House")
    (LDESC 
"More show home than home. Ed's house is so immaculately clean, organised and tidy that it's hard to
believe that anyone actually lives here. The thick shag pile cream carpet is spotless. The air in
the room catches your breath. There are plug in air freshers in every power socket, they are set to
maximum so there is a constant background 'psst' 'pssst' rhythm as they dispense 'sweet pea and
lilac' scent into the room.||On the walls are photos from gigs showing Ed in his many 'power poses'
with everyone else in the band cropped out or blurred.")
    (OUT TO OUTSIDE-ED-KAYCES-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM TRINITY-LANE
    (DESC "Trinity Lane")
    (IN ROOMS)
    (NORTH TO TOWN-SQUARE)
    (SOUTH TO OUTSIDE-KFC)
    (EAST TO OUTSIDE-ED-KAYCES-HOUSE)
    (SW TO BEHIND-THE-GREASY-SPOON-CAFE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-KFC
    (DESC "Outside KFC")
    (IN ROOMS)
    (NORTH TO TRINITY-LANE)
    (FLAGS LIGHTBIT)>


<ROOM KFC-DRIVE-THROUGH
    (DESC "KFC Drive-Through")
    (IN ROOMS)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-CLUCK-YOU-WAREHOUSE
    (DESC "Outside Cluck You! Warehouse")
    (LDESC
"You are outside an enormous industrial warehouse. The stench of ammonia is heavy in the air and you
can faintly hear the sound of squawking poultry from within.")
    (IN ROOMS)
    (IN TO CLUCK-YOU-WAREHOUSE)
    (FLAGS LIGHTBIT)>


<ROOM CLUCK-YOU-WAREHOUSE
    (DESC "Cluck You! Warehouse")
    (IN ROOMS)
    (OUT TO OUTSIDE-CLUCK-YOU-WAREHOUSE)
    (FLAGS LIGHTBIT)>


<ROOM BLACKFRIARS-ROAD
    (DESC "Blackfriars Road")
    (LDESC
"The western corridor of the town. To the North lies the Blackfriar's Inn, to the East is Oxford
Road, Broughton Lane lies to the South and the band's bassist Spider Jones lives to the West.")
    (IN ROOMS)
    (NORTH TO OUTSIDE-THE-BLACKFRIARS-INN)
    (SOUTH TO BROUGHTON-LANE)
    (EAST TO OXFORD-ROAD)
    (WEST TO OUTSIDE-SPIDER-JONES-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-SPIDER-JONES-HOUSE
    (DESC "Outside Spider Jones' House")
    (LDESC
"You are outside Spider Jones' house, the bass player of the band and all round dozy waster.||TODO")
    (IN ROOMS)
    (EAST TO BLACKFRIARS-ROAD)
    (IN TO SPIDER-JONES-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-THE-BLACKFRIARS-INN
    (DESC "Outside the Blackfriars Inn")
    (IN ROOMS)
    (SOUTH TO BLACKFRIARS-ROAD)
    (IN TO BLACKFRIARS-INN)
    (FLAGS LIGHTBIT)>


<ROOM BLACKFRIARS-INN
    (DESC "Blackfriars Inn")
    (LDESC
"A large victorian coaching house, converted to a thousand capacity music venue in the 1970's. It's
seen better times, and could do with a face-lift, but the acoustics are excellent.")
    (IN ROOMS)
    (NORTH TO BACKSTAGE)
    (OUT TO OUTSIDE-THE-BLACKFRIARS-INN)
    (FLAGS LIGHTBIT)>


<ROOM BACKSTAGE
    (DESC "Backstage")
    (IN ROOMS)
    (SOUTH TO BLACKFRIARS-INN)
    (FLAGS LIGHTBIT)>


<ROOM BROUGHTON-LANE
    (DESC "Broughton Lane")
    (IN ROOMS)
    (NORTH TO BLACKFRIARS-ROAD)
    (SOUTH TO JONS-LOCK-UP)
    (WEST TO OUTSIDE-MIKE-E-SMITHS-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM JONS-LOCK-UP
    (DESC "Jon's Lock-Up")
    (LDESC
"Jon's lock-up garage where he keeps the van and does amateur maintenance on it; although that
doesn't seem to include ever cleaning it.")
    (IN ROOMS)
    (NORTH TO BROUGHTON-LANE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-MIKE-E-SMITHS-HOUSE
    (DESC "Outside Mike E. Smith's House")
    (LDESC
"A rough part of town. Mike's home is currently a run down house. He's on hard times and the rent is
cheap. The driveway is covered in potholes. The front door is covered in peeling paint. The gutter
around the roof appears to be leaking, and there is a big crack in one of the upstairs windows.
[first time]||'Poor Mike,' says Jonny. 'He's really on his uppers.'[only]")
    (IN ROOMS)
    (EAST TO BROUGHTON-LANE)
    (IN TO MIKE-E-SMITHS-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM MIKE-E-SMITHS-HOUSE
    (DESC "Mike E. Smith's House")
    (LDESC
"Inside Mike's house is a depressing sight. The house feels and smells damp, with black mould
growing in the upper corners of the walls. The carpet is threadbare and the furniture is ancient.
[first time]||Jonny catches your eye and subtly draws your attention to the pile of red bills on the
coffee table.[only]")
    (IN ROOMS)
    (OUT TO OUTSIDE-MIKE-E-SMITHS-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM SPIDER-JONES-HOUSE
    (DESC "Spider Jones' House")
    (IN ROOMS)
    (OUT TO OUTSIDE-SPIDER-JONES-HOUSE)
    (FLAGS LIGHTBIT)>


<ROOM OUTSIDE-DISCOVERY-RECORDS
    (DESC "Outside Discovery Records")
    (IN ROOMS)
    (NE TO TOWN-SQUARE)
    (IN TO DISCOVERY-RECORD-STORE)
    (FLAGS LIGHTBIT)>


<ROOM DISCOVERY-RECORD-STORE
    (DESC "Discovery Record Store")
    (LDESC
"Discovery Record Store. Specialising in vinyl it managed to scrape through and survive the digital
revolution of CDs and streaming services, and is now enjoying a renaissance as a popular hangout for
the local hipster community.[paragraph break]There are racks and racks of vinyl records, arranged by
genre and alphabetical order. On the walls are special edition picture discs, and limited-edition
coloured vinyl discs. Some cheesy music is drifting out of the store Hi-Fi system.")
    (IN ROOMS)
    (OUT TO OUTSIDE-DISCOVERY-RECORDS)
    (FLAGS LIGHTBIT)>

