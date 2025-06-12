' Quest ASL Template

' All sections must exist in the game, though the text sections may be empty
' if desired.

define game <The Adventures of Koww the Magician>
    asl-version <200>
	game version <1.0>
	game author <Brian the Great>
	game copyright <© 1999...>
	game info <Koww is a magical cow trying to figure out whether the grass is greener on the other side of the chasm.>
    start <Koww's Chasm>
    possitems <fly scroll, wing feather, jade statuette, milk, pitchfork, goblin spit, something, nothing, duck turd, grappling hook, purple paint>
    startitems <milk>
	collectables <>
error <itemunwanted;#quest.error.charactername# couldn't care less about your damn item.>
end define

' ************KOWW'S CHASM************
define room <Koww's Chasm>
	command <read #1#> if is <#1#;sign> then exec <look at sign> else msg <What the hell is a #1#?>
	command <use #1#> if is <#1#;fly scroll> then do <finishproc>
	look <You are outside in a pasture of pure, pure green.  Green as far as the eye can see.  But you, Koww the Magician, are not satisfied.  The grass may be even greener on the other side of the |bchasm|xb... you must know!  Also in the area is a very undramatic |bsign|xb.>
	define object <sign>
		prefix <a>
		look <It reads: "|iGot milk?  Come to Farmer Zeke's mag-NIFicent silo!|xi">
		take msg <You yank the sign out of the ground and try to fit it in your Koww-pack.  But it just doesn't fit.  Frustrated, you put it back.>
	end define
	define object <chasm>
		prefix <the>
		look <That's the chasm you simply MUST cross!  Surely the only way to cross it is to FLY!> 
		take msg <Don't worry, the men in the white coats will soon be here to deal with you.>
	end define
	command <fly> {
		msg <That's not a spell you know.  But perhaps if you could find a scroll -- like the ones owned by the Great Phoenix -- you could do so.>}
	east <Zeke's Farm>
end define
define procedure <finishproc>
	if got <fly scroll> then do <endproc> else msg <Maybe you'll find it someday, but you don't have it today.  You stupid cow.>
end define
define procedure <endproc>
	msg <You fly up and over the chasm!>
	playerwin
end define
'***********ZEKE'S FARM**********
define room <Zeke's Farm>
	command <eat #1#> if is <#1#;haystack> then exec <take haystack> else msg <That doesn't look appetizing.  You chew your cud instead.>
	command <drink #1#> if is <#1#;pond> then exec <take pond> else msg <What, drink THAT?!?!?  You loony.>
	look <You stand outside of a small |bfarmhouse|xb with a |bsilo|xb beside it.  There are a |bhaystack|xb and a |bpond|xb here.>
	define object <haystack>
		prefix <the>
		look <About what you'd expect from a haystack.  It's made of... HAY!  You munch on it for a while.>
		take msg <You take a bite of the haystack.  Yummy... tastes just like chicken!>
		use <pitchfork> do <openstatuecaveproc>
	end define
	define object <pond>
		prefix <the>
		look <A nice, placid pond full of little tiny duckies.  Ooo, how cute!  If you were carnivorous, they'd make you hungry.>
		take msg <You sip the water from the pond.  Just what you need to wash down a bit of grazing.>
		use <something> do <getduckturd>
	end define
	west <Koww's Chasm>
	south <Goblin Trail>
	east <Phoenix Mountain Pass>
	north <Land of the NecroYaks>
	place <Zeke's Farmhouse>
	place <Zeke's Silo>
end define
	
define procedure <openstatuecaveproc>
	msg <You stab the pitchfork into the haystack.  Lo and behold, the haystack falls down into a hole in the ground!  Inside the hole is a jade statuette, which you take.>
	lose <pitchfork>
	give <jade statuette>
end define
'end define

define procedure <getduckturd>
	msg <You throw the something into the lake.  The ducks swarm around it in curiosity.  You take the opportunity to grab a duck turd without being noticed!>
	lose <something>
	give <duck turd>
end define
'************ZEKE'S FARMHOUSE**********
define room <Zeke's Farmhouse>
	command <take #1#> if is <#1#;treasure chest> then msg <It's too big.  You could open it instead...> else exec <take #1#;normal>
	command <open #1#> if is <#1#;treasure chest> then do <getnothing> else exec <open #1#;normal>
	look <You're inside Farmer Zeke's rather cramped home.  No one's here at the moment.  Perhaps you should go away.>
	out <Zeke's Farm>
	define object <table>
		prefix <the>
		look <Hmmm, what's a table doing here?  Cool!  It has a |btreasure chest|xb on it!>
		take msg <Farmer Zeke took the wise precaution of bolting his table to the floor.>
	end define
end define

define procedure <getnothing>
	msg <Ooooo!  There's nothing inside!  Told ya you should have gone away.>
	give <nothing>
	hideobject <table@Zeke's Farmhouse>
end define
'*************ZEKE'S SILO**************
define room <Zeke's Silo>
	out <Zeke's Farm>
	command <kill #1#> if is <#1#;Zeke> then msg <You may be an evil sorcerer, but at least you're an ETHICAL evil sorcerer.  No killing allowed!  Especially not of idiots.  They don't know they're idiots.>
	command <splash milk on #1#> if is <#1#;Zeke> then do <dumblose> else msg <Why would you do that?  Awful waste of milk.>
	command <use #1#> if is <#1#;purple paint> then do <purpleuse> else exec <use #1#;normal>
	look <Gee, this place smells just like rotting feed.  Standing in the silo, grinning like the idiot that he is, is Farmer |bZeke|xb.>	
	define character <Zeke>
		gender <he>
		look <He's wearing a straw hat and at least one of his teeth is rotting away, but he seems pleased as punch that you've arrived.>
		speak <Hey there, good buddy!  Say, bein' a wizard an' all, couldja find it in yer heart to gimme some magic milk?  I'm all out!>
		give <milk> do <pitchproc>
	end define
	
end define

define procedure <pitchproc>
	lose <milk>
	give <pitchfork>
	say <Well, thanks a lot, good buddy!  Well, tell ya what, why don't I give ya this here pitchfork ta comp'n'sate ya fer yer milk.>
end define

define procedure <dumblose>
	say <Well, gee," says Farmer Zeke, "I shore do like ya a lot, but I guess there's a limit!">
	msg <So saying, Zeke stabs you with his pitchfork.>
	playerlose
end define
define procedure <purpleuse>
	if got <purple paint> then do <purplecow> else msg <You don't know where that is!>
end define
define procedure <purplecow>
	lose <purple paint>
	msg <You spread the purple paint on yourself.  Suddenly Farmer Zeke bursts into song!>
	say <|iI never saw a purple cow, and I never hope to see one; but I can tell you anyhow, I'd rather see than be one!|xi>
	msg <Wonderful!  You have just activated the scenario's secret feature!  That's it.  Return to your home.  There's nothing more to do here.>
end define
'*************GOBLIN TRAIL***************
define room <Goblin Trail>
	north <Zeke's Farm>
	south <Goblin Lair>
	look <The stench of goblins permeates this place.  Goblins are small, annoying creatures who like to fight anyone who looks weak.  Fortunately, you don't look weak.>
	define object <road>
		prefix <the>
		look <It's made of dirt.  Concrete hasn't been invented yet.>
		take msg <But you're already taking the road!  You're taking it either north or south!  Har har har!  Hey, I saw a car transform the other day!  Yeah, it turned into a driveway!>
	end define
end define
'*************GOBLIN LAIR****************
define room <Goblin Lair>
	command <climb #1#> if is <#1#;cliff> then msg <After a difficult climb, you reach the top.  You're very pleased with yourself.  Unfortunately, the ledge crumbles beneath you and you plummet back to the ground.>
	north <Goblin Trail>
	place <Inside the Goblin Lair>
	look <About twenty goblins patrol the front of a massive cave complex.  They eye you for a moment, then decide not to attack.  You return the favor and don't kill them.>
	define object <cliff>
		prefix <the>
		look <It's a cliff; you could climb it, but it might be a difficult climb.>
		take msg <If you want to climb the cliff, say so!>
	end define
	define character <goblin guard>
		prefix <the>
		gender <it>
		look <It's very ugly, like most of its kind.  Don't get too close; you could faint from the smell.>
		speak <Yu wan go cave?  No try no funny bizniss -- I can tell.>
		give <nothing> do <secretone>
	end define
end define
define procedure <secretone>
	say <Ooooo!  Nuthing!  Jus wut I all ways want'd!  Inn ex chaynge, I giv yu summ thing!>
	lose <nothing>
	give <something>
end define
'**************INSIDE THE GOBLIN LAIR*************
define room <Inside the Goblin Lair>
	out <Goblin Lair>
	look <You are escorted to the Goblin King's throne room, a large chamber ornamented with |bstatues|xb of nude female goblins.  You try hard to avoid puking.>
	define object <statues>
		prefix <the>
		look <Apparently, the goblin idea of beauty is the same as the bovine idea of putridity.  You'd prefer not to look at these statues.>
		take msg <That would be difficult, considering the statues are about seven feet tall, are made of stone, weigh about a ton, and are guarded by some mean-looking goblins.>
	end define
	define character <Goblin King>
		prefix <the>
		gender <he>
		look <An officious-looking, double-chinned goblin monarch sits royally atop a throne of deer hide.>
		speak <Hoo hoo hoo!  Goblinz so grate, our spit is assid!  We spit on yu if yu make us angree!  If yu hav tiny statyoo of jade, we giv yu nice thing!>
		give <jade statuette> do <giftofking>
		give <duck turd> do <othergift>
	end define
end define

define procedure <giftofking>
	lose <jade statuette>
	give <goblin spit>
	say <Ooooo!  You find goblinn lost statyoo!  We giv yu wun jar of spit!>
end define
define procedure <othergift>
	lose <duck turd>
	give <grappling hook>
	say <Ooooo!  GIMME GIMME GIMME!  Duck turd favorite goblin food!  We giv yu grapple hook!>
end define
'***************LAND OF THE NECROYAKS**************
define room <Land of the NecroYaks>
	south <Zeke's Farm>
	north <Ambush Point>
	command <read #1#> if is <#1#;sign> then exec <look at sign> else msg <What the hell is a #1#?>
	look <The greenness of the farmland dissolves into gray bleakness as you pass into the land of the NecroYaks.  Yaks are the sworn enemies of cows -- you'd better stay on your toes!>
	define object <sign>
		prefix <a>
		look <It reads: "Unless you own a vial of acid that you can give to the NecroYaks for their sinister experiments, do not proceed on pain of Death!">
		take msg <Oh, THAT'S original.>
	end define
end define
'***************AMBUSH POINT***************
define room <Ambush Point>
	alias <Deep in NecroYak Territory>
	command <search> if got <goblin spit> then do <yakslove> else do <yakskill>
	south <Land of the NecroYaks>
	look <A cliff face blocks your way here.  It's steep -- you can't climb.  If you want to continue, you'll have to |bsearch|xb the face.>
end define
define procedure <yakskill>
	msg <The NecroYaks recognize you as a cow, then jump out and kill you.>
	playerlose
end define
define procedure <yakslove>
	msg <The NecroYaks jump out and search you for acid.  They find your goblin spit, take it, and run off.  But one of them drops a phoenix feather, and you scoop it up unnoticed.  By the way, there's no way to go farther this way unless you're a yak.>
	lose <goblin spit>
	give <wing feather>
end define
'***************PHOENIX MOUNTAIN PASS***************
define room <Phoenix Mountain Pass>
	command <climb #1#> if got <grappling hook> then do <climbthem> else msg <Those particular mountains are too steep.>
	west <Zeke's Farm>
	east <Phoenix Peak>
	look <The towering mountains surround you on all sides but back to your west.  Passage farther east is remotely possible, should you be brave or foolhardy enough to try it.>
	define object <mountains>
		prefix <the>
		look <They tower up almost as high as the Great Auk Mountains far, far to the north.>
		take msg <After several hours of effort, you manage to chip a piece off of the mountain you're standing on.  But you accidentally let go and it plummets into the valley below.>
		use <grappling hook> if got <grappling hook> then do <climbthem> else msg <Those particular mountains are too steep.>
	end define
end define
define procedure <climbthem>
	lose <grappling hook>
	give <purple paint>
	msg <On top of the mountain, you find a bunch of purple paint, which you take.  After descending again, you ditch your grappling hook.>
end define
'***************PHOENIX PEAK****************
define room <Phoenix Peak>
	command <Yes> if got <wing feather> then do <phoenixproc> else do <phoenixkill>
	command <No> say <Then leave me immediately, as I do not appreciate company.>
	west <Phoenix Mountain Pass>
	look <After hard hours of climbing, you finally reach the summit of Phoenix Peak.  Here, in all its glory, sits the |bResplendent Magnificent Phoenix|xb.>  
	define character <Resplendent Magnificent Phoenix>
		gender <he>
		prefix <the>
		look <The Resplendent Magnificent Phoenix's visage is so brilliant that it hurts to look at it.>
		speak <The Resplendent Magnificent Phoenix demands to know |iwhy|xi such a weakling as you has come here!  If you do not have my wing feather with you, I'm afraid I must ask you to leave |iimmediately!|xi  Now, do you have my wing feather or not -- |bYes|xb or |bNo|xb?>
		give <wing feather> say <I asked you a question!!!  Please answer |bYes|xb or |bNo|xb or so help me, I will not let you leave here alive!>
	end define		
end define
define procedure <phoenixproc>
say <Thank you; you have found my wing feather.  In the wrong hands, that could have been very dangerous.  I will give you this "fly" scroll to compensate you for your hard work.  |bUse|xb the scroll to fly, but it will only work once.>
give <fly scroll>
lose <wing feather>
end define
define procedure <phoenixkill>
say <Then give it to me quickly!  What..... You don't have my wing feather at all, do you?  You shammer.  I was going to dismiss you without hurting you, but I'm afraid now I'll have to kill you.>
msg <The Resplendent Magnificent Phoenix bats you with one claw.  You roll back down the mountainside, finally coming to a complete stop looking very much like a well-done steak.>
playerlose
end define
'*************END OF ROOM DESCRIPTIONS***********
define text <intro>
Find out if the grass is really greener on the other side of the chasm.
end define

define text <win>
Congratulations, you have found out that you were better off where you started anyway.  The grass here is brown and crackly.  Too bad!  And... OH NO!  Now you're trapped here, alone with the NecroYaks!  Stay tuned for "The Adventures of Koww the Magician II -- Escape from the NecroYaks!"
end define

define text <lose>
Idiot.  You die.  HA HA HA HA HA!
end define