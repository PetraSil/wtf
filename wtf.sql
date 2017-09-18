DROP DATABASE IF EXISTS wtf;
CREATE DATABASE wtf;
USE wtf;

CREATE TABLE location
(
  locationname VARCHAR(40) NOT NULL,
  description MEDIUMTEXT NOT NULL,
  locationid INT NOT NULL,
  PRIMARY KEY (locationid)
);

CREATE TABLE player
(
  playername INT NOT NULL,
  oravannahka INT NOT NULL,
  hitpoints INT NOT NULL,
  playerid INT NOT NULL,
  locationid INT NOT NULL,
  PRIMARY KEY (playerid),
  FOREIGN KEY (locationid) REFERENCES location(locationid)
);

CREATE TABLE npc
(
  npcname VARCHAR(40) NOT NULL,
  description MEDIUMTEXT NOT NULL,
  npcid INT NOT NULL,
  npctype INT NOT NULL,
  locationid INT NULL,
  PRIMARY KEY (npcid),
  FOREIGN KEY (locationid) REFERENCES location(locationid)
);

CREATE TABLE dialogue
(
  dialogues MEDIUMTEXT NOT NULL,
  isRiddle INT NOT NULL,
  dialID INT NOT NULL,
  penalty INT NOT NULL,
  npcid INT NOT NULL,
  PRIMARY KEY (dialID),
  FOREIGN KEY (npcid) REFERENCES npc(npcid)
);

CREATE TABLE objects
(
  objectId INT NOT NULL,
  objectname VARCHAR(40) NOT NULL,
  description MEDIUMTEXT NOT NULL,
  PRIMARY KEY (objectId)
);

CREATE TABLE dialogueoptions
(
  dialoptid INT NOT NULL,
  dialparentid INT NOT NULL,
  dialchildid INT NOT NULL,
  dialstate INT NOT NULL,
  dialID INT NOT NULL,
  PRIMARY KEY (dialoptid),
  FOREIGN KEY (dialID) REFERENCES dialogue(dialID)
);

CREATE TABLE transition
(
  locationidone INT NOT NULL,
  locationidtwo INT NOT NULL,
  FOREIGN KEY (locationidone) REFERENCES location(locationid),
  FOREIGN KEY (locationidtwo) REFERENCES location(locationid)
);

CREATE TABLE commands
(
  commandid INT NOT NULL,
  commandname VARCHAR(30) NOT NULL,
  PRIMARY KEY (commandid)
);

CREATE TABLE items
(
  itemname VARCHAR(40) NOT NULL,
  description MEDIUMTEXT NOT NULL,
  inInvetory INT NOT NULL,
  hitpointsaffect INT NOT NULL,
  value INT NOT NULL,
  amount INT NOT NULL,
  itemid INT NOT NULL,
  locationID INT NOT NULL,
  npcid INT NOT NULL,
  objectId INT NOT NULL,
  PRIMARY KEY (itemid),
  FOREIGN KEY (locationID) REFERENCES location(locationid),
  FOREIGN KEY (npcid) REFERENCES npc(npcid),
  FOREIGN KEY (objectId) REFERENCES objects(objectId)
);

CREATE TABLE crafting
(
  itemidone INT NOT NULL,
  itemidtwo INT NOT NULL,
  FOREIGN KEY (itemidone) REFERENCES items(itemid),
  FOREIGN KEY (itemidtwo) REFERENCES items(itemid)
);

CREATE TABLE useitemobj
(
  objectId INT NOT NULL,
  itemid INT NOT NULL,
  FOREIGN KEY (objectId) REFERENCES objects(objectId),
  FOREIGN KEY (itemid) REFERENCES items(itemid)
);

CREATE TABLE useitemnpc
(
  itemid INT NOT NULL,
  npcid INT NOT NULL,
  FOREIGN KEY (itemid) REFERENCES items(itemid),
  FOREIGN KEY (npcid) REFERENCES npc(npcid)
);

CREATE TABLE parserlibrary
(
  libid INT NOT NULL,
  abbreviation VARCHAR(255) NOT NULL,
  objectId INT NOT NULL,
  npcid INT NOT NULL,
  locationid INT NOT NULL,
  itemid INT NOT NULL,
  commandid INT NOT NULL,
  PRIMARY KEY (libid),
  FOREIGN KEY (objectId) REFERENCES objects(objectId),
  FOREIGN KEY (npcid) REFERENCES npc(npcid),
  FOREIGN KEY (locationid) REFERENCES location(locationid),
  FOREIGN KEY (itemid) REFERENCES items(itemid),
  FOREIGN KEY (commandid) REFERENCES commands(commandid)
);

# Create game commands
INSERT INTO commands VALUES (1, "talk to");
INSERT INTO commands VALUES (2, "examine");
INSERT INTO commands VALUES (3, "go to");
INSERT INTO commands VALUES (4, "inventory");
INSERT INTO commands VALUES (5, "use");
INSERT INTO commands VALUES (6, "help");
INSERT INTO commands VALUES (7, "ask mario");
INSERT INTO commands VALUES (8, "value");
INSERT INTO commands VALUES (9, "sell");
INSERT INTO commands VALUES (10, "buy");
INSERT INTO commands VALUES (11, "kick");

# Create locations
INSERT INTO location VALUES ("Metropolia, Bulevardi", "One of the large campuses that is situated in Helsinki. Bulevardi campus is among the older buildings in the area and is truly a sight to see with its huge windows and large columns. This is where the players story begins when the player meets the Shady Character. The Group of Stu-dents is also located here and they will provide the player with useful information.", 1);
INSERT INTO location VALUES ("Bulevardi", "A place for the posh, the stylish and the capitalist pigs! You have them all here, packed in neat rows in their old jugend style houses that no one can afford. You can also spot some out of place students wandering the streets of Bulevardi as one of the Metropolia campuses is locat-ed here. They usually get some condescending looks from the true bulevardians. Here, from Torsti the Tutor, the player can get potassium nitrate, charcoal and sulphur for the powder that is required to make bullets.", 2);
INSERT INTO location VALUES ("Mannerheimintie", "One word describes Mannerheimintie and that is traffic. Walking through and about this area gives you a good chance to inhale so many toxic fumes that you’ll shorten your lifespan with every step. Mannerheimintie is also infamous for always being under construction. Broken streetlamps, rubble everywhere and workers who try to appear busy is what you’ll find here. Karri the Gardener has a stall here where the player can find many curious items.", 3);
INSERT INTO location VALUES ("Aleksanterinkatu", "One of the busiest streets that you can find in Helsinki and, at least in theory, one of the pretti-est. Perhaps it was in the past but no longer. The streets are filled with craters and dust and you could almost say the same about the humans that keep moving about like zombies. The European Federation has ordered a statue of the great Emperor to be built here and that is why Rolle the Rock Sculptor spends most of his days here chiselling away with great abandon.", 4);
INSERT INTO location VALUES ("Keskuskatu", "Keskuskatu, also known as the dark street, lost most of its electricity several years back and despite the mediocre efforts of the city, they haven’t returned. There are few electric engineers here at random hours attempting to fix something they probably cannot. Erkki the Electrician practically lives here as he has been ordered to remain at his post until the electricity has been returned.", 5);
INSERT INTO location VALUES ("Eye clinic", "The eye clinic is the only truly operational store where people can purchase commodities in Keskuskatu. The Eye Clinic clerk is named Olli the Optician and the player has to purchase GLASSES from him should he desire to.", 6);
INSERT INTO location VALUES ("Kaivokatu", "Despite its name, Kaivokatu has no wells. They were removed years ago after the Emperor tripped on one of them and had a tantrum. This has led to Kaivokatu always being somewhat damp and flooded. There are beggars here huddled between countless trash cans that almost act like an urban forest.", 7);
INSERT INTO location VALUES ("Central Railway Station", "Central railway station is the centre of transportation in Helsinki and you could call it one of the major hubs of Helsinki. It can be accessed from Kaivokatu. The player can ride the subway car from the lower levels of the Central railway station. Aatu the neo-Nazi can be found from the street level of the Central railway station.", 8);
INSERT INTO location VALUES ("Asematunneli", "Lower level of the central railway station and as a place of interest, Asematunneli is somewhat unremarkable. There is space, there are shops and there are people, but almost all of them are uninteresting. This is the kind of place where you simply just wish to move on unless one of the odd shops piques your interest. Charlie the Android shopkeeper has a stall here. You can go down the stairs to reach Kompassitaso.", 9);
INSERT INTO location VALUES ("Kompassitaso", "Lower level from Asematunneli and truly a no place for humans. Many places have changed over the years but not Kompassitaso. It is still a miserable place for miserable people to feel miserable while they do their best to navigate through the horrors of what is Kompassitaso. Behind every corner there are perils like Jehovah’s witnesses, street artists and people who try to get you to sign papers to support their pointless cause. The player can access the subway station from here.", 10);
INSERT INTO location VALUES ("Central Subway Station", "Part of the main railway station in Helsinki. It is almost as busy as the railway station it-self and filled with anxious people that make it seem like a beehive, both in traffic and the incredibly suffocating and stressful atmosphere that lingers there. You can travel to other subway sta-tions from here. The player also should remember to buy a ticket from the ticket vending ma-chine before boarding a tram or there will be trouble!", 11);
INSERT INTO location VALUES ("Subway Car", "Unreliable, unclean and unpleasant. The subway acts like the veins of the city, veins that have been clogged by years of bad habits. Scientists have also tried to discover why are there never any free seats in the metro but have been unable to find a logical answer. To survive the sub-way with all of your senses and health, one should always make sure not to annoy the ticket inspectors. They have no feelings of the human kind. The subway cars will take you from loca-tion of the city to another in a flash.", 12);
INSERT INTO location VALUES ("Sörnäinen Subway Station", "There are three kinds of people that inhabit the Sörnäinen subway station. Drug dealers who want to give you the trip of your lifetime, agents of the Emperor who are ready to rough you up for no real reason and then people like you, who everyone else is trying to take advantage of. Spend as little time here as possible. There is a ticket vending machine here.", 13);
INSERT INTO location VALUES ("Sörnäinen", "Due to the nuclear war and the aftermath of the war, Sörnäinen was desolated, and the rubble from the buildings filled the streets and alleys alike. Nowadays the subway car is the only way to access Sörnäinen and only few people remain there, mostly old people and people who still hold Sörnäinen close to their heart. The player can find “The Bullet casing mould Blueprint”, “Lead Pipe” and “SHOVEL” from Sörnäinen. Bob the Boozer also resides within Sörnäinen.", 14);
INSERT INTO location VALUES ("The Sinkhole", "There are plenty of bars in Sörnäinen but only one like The Sinkhole. While the official name of the bar is The Sinkhole, it has been given a nickname, The Stinkhole, by those who do not ap-preciate the odours that have been cultivating in the bar for years and years. There are rumours, that if you have a drink there, you will always come back for another. That is most likely due to the stench that latches on to you like glue which leads to no one but the regular denizens of the bar wanting to spend their time with you.", 15);
INSERT INTO location VALUES ("Myllypuro Subway Station", "Myllypuro station is just like any other metro station, so both pretty and ugly at the same time. Graffiti, vomit, trash, you name it and you’ll find it here. The player can find valuables here from the countless trash cans. There is also a ticket vending machine here.", 16);
INSERT INTO location VALUES ("Metropolia, Myllypuro", "Myllypuro campus is the latest of all the campuses. It was finished 2029, only 20 years after it was planned to be finished. Not bad, as länsimetro still isn’t finished. Here the player will find the Pentti, janitor of the campus, who will supply the player with liquid nitrogen and Bunsen burner.", 17);
INSERT INTO location VALUES ("Kontula Subway Station", "A relic from days gone by and the station is about to crumble beneath its own weight. This is the kind of place you rather not walk through during the late hours as it is usually inhabited by those who have a habit of not liking your face. The player can find valuables here from one of the trash cans and a ticket vending machine is also located here.", 18);
INSERT INTO location VALUES ("Kontula Shopping Mall", "Truly the jewel of the east. This is what the future looks like. Kontula shopping mall is like a monument of the greatness that is the European Federation and its magnificent leader. Full of riches and innovation, that unfortunately, is out of the reach for most common folk. Reino the Resistance dude is a regular occupant of the shopping mall and he will give the player his final instructions, comments and regards before the player enters the lift to the upper floors to finish his quest.", 19);
INSERT INTO location VALUES ("Kontula Mall Skyscraper", "As tall as it is ugly. It was the vision of the Emperor to have this monster of a building to be built in the glorious neighbourhood of Kontula. The climax of the game takes place in the room 2311 on 23rd floor of the Kontula mall skyscraper. The player needs to assemble the sniper rifle and the modifications for it before entering here. After having the sniper spot all set up the player takes a shot at assassinating the evil emperor of the European federation “Han-on-king”.", 20);
INSERT INTO location VALUES ("Room 2311", "A room on the 23rd floor of Kontula Skyscraper that is located within Kontula Mall. One of the highest floors of the building so this is the kind of room that only few get to see. It has a nice view of the whole mall where it resides.", 21);

## Create NPCS
INSERT INTO npc VALUES ("Mario", "He is a 36 years old Italian plumber who got fed up with his day job and decided to move to Finland to study another occupation and he is a classmate of the player character. If Mario is brought along he moves around the world with the player and he will help the player to best of his abilities. He has formed an appetite for magical mushrooms which can lead the player in trouble. If Mario consumes magical mushrooms he will imagine that he can shoot fireballs and will start hunting for flying stars that blink really, really fast. Player can also call Mario at any time and ask for help if he is stuck, in case Mario wasn’t brought along. Bringing Mario along is optional.", 1, 1, NULL);
INSERT INTO npc VALUES ("Shady Character", "Every story has stereotypes. Here is one for this particular one. He is a mystery in every way. Where he comes from, what does he do and why does he wear such a big hat? Nobody knows. What is known is that he is somehow related to the resistance that is the opposing force to the new world order.", 2, 2, 1);
INSERT INTO npc VALUES ("Torsti the Tutor Dude", "Tutors, those ever so helpful senior students that seem to know everything you do not. Torsti, in particular, is a chemistry student and a damn smart one at that. He is always jolly and always ready to share his knowledge to those who are willing to listen.", 3, 2, 2);
INSERT INTO npc VALUES ("A group of students", "What does every school have? Students. Lots of students. When enough of them gather in one spot they group up and become a semi-intellectual mass that you can communicate with. These groups are filled with witty knowledge, both useless and not so useless. In other words, if it is directions you want or to know why you should never divide by zero, ask a group of students.", 4, 2, 2);
INSERT INTO npc VALUES ("Karri the Gardener", "Gardeners are a weird bunch. Nobody truly understands them and why they wish to spend their days plucking weeds from the ground and plant all sorts of weird flowers in their place. No-body knows. Nobody. Karri, the burly gardener, has a store in Mannerheimintie where all his of flowers, hoses, fertilizers and such are on display.", 5, 2, 3);
INSERT INTO npc VALUES ("Rolle the Rock Sculptor", "He loves to talk. Oh, how he loves to talk. The only thing that he loves as much as educating others about the new world order, conspiracy theories and aliens, is rock sculpting. He takes great pride in his work and his tools of the trade.", 6, 2, 4);
INSERT INTO npc VALUES ("Erkki the electrician", "No matter what year it is there will always be work for good old electricians. Erkki is one of them. Face full of thick beard and hands that have seen years of hard work, Erkki is at the moment working on a curious led-lighting instalment on Kaivokatu.", 7, 2, 5);
INSERT INTO npc VALUES ("Olli the Optician", "Olli is not your typical optician. He is large, muscular like a wrestler and with a jaw that looks like it was made from stone. Despite his large appearance, he if most likely the kindest person you will meet in Helsinki so be sure to return his kindness if you run into him.", 8, 2, 6);
INSERT INTO npc VALUES ("Beggar", "Beggars can't be choosers. Especially if you live in the dystopic Helsinki or 2030. Like them or hate them, these resilient wanderers see things that you might not. That is one of the few bene-fits of living like a beggar, you have knowledge of the city. Show a beggar some kindness and they might offer you something in return.", 9, 2, 7);
INSERT INTO npc VALUES ("Aatu the Neo-Nazi", "Be it the 1940's or 2030's, there will be fascists. While you cannot trust them, you can be sure you can find them glamouring the statue of Mannerheim near Kiasma. You best stay away from them unless you feel desperate or lucky. Or even better, both.",  10, 2, 8);
INSERT INTO npc VALUES ("Mathilda", "No matter what the year is, Swedish tourists can be found everywhere. Like all of them swedes, Mathilda is a happy-go-lucky person. Truly a stereotype if there ever was one. Swedish tourists are a wealthy bunch and enjoy a good talk with the more common Finns, who always manage to amuse them. ", 11, 2, 8);
INSERT INTO npc VALUES ("Charlie the Android Shopkeeper", "This android is the exception, one that only wants to fit in (clearly a programming error). Charlie has put up a curious shop, or \"a shop of great importance\", as he calls it, in the ever busy Ase-matunneli in Helsinki. Perhaps he will have something important or perhaps he will not and it is up to you to find out!", 12, 2, 9);
INSERT INTO npc VALUES ("Karl the Junkie", "Junkies, the bane of mankind. Both misunderstood and unpredictable at the same time. When you around a junkie you best be careful with your words and make sure you do not irritate them (which is not always easy) as picking a fight with these individuals is never a good idea.", 13, 2, 10);
INSERT INTO npc VALUES ("Street Fundraiser (feissari)", "One of the most despised characters in the world. We all know who they are and can feel our breathing becoming shallow when we see them approaching us and attempting to make eye contact. ", 14, 3, 11);
INSERT INTO npc VALUES ("Ticket Inspector","She is there to make sure no-one takes advantage of the glorious metro of Helsinki without paying the proper fee. If you have a ticket, she will be your friend. If you do not, you can be sure there will be trouble...", 15, 2, 12);
