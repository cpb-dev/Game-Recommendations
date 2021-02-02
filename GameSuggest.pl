/* -------------------------- */
/* Game Recommendation System */
/* -------------------------- */

begin:-
	initialise,	% drive predicate
	collect_info,
	rule(Game),
	recommendation(Game,Reply),
	write('Recommendation:'),nl,
	write(Reply),nl,
	retractall(genre(_)).	% clearing data entries to database

begin:-		% warning if failed to load data
	write('Sorry cannot help!'),nl,nl,
	retractall(genre(_)).

genres :-	% function to display the games within a specified genre
	genrechoice(Gen),
	genrelist(Gen,Games),
	writelist(Games).

/* User Interface */

initialise:-
	nl,nl,nl,
	tab(20),write('Welcome to Conor and Joes Game Recommendations!'),nl,
	write('Please answer the following questions!'),
	write(' y (yes) or n (no).'),nl,nl.

collect_info:-	% asking the questions and acknowledging a response
	question(Quest,Gen),
	write(Quest),nl,
	getyesno(Yesno),nl,
	(Yesno='yes';Yesno='y'),
	assertz(genre(Gen)),
	(Yesno='no';Yesno='n'),
	retract(genre(Gen)),
	fail.

collect_info.

getyesno(X):-
	repeat,
	write('Please answer y or n:'),nl,
	read(Z),nl,
	check(Z),
	X=Z,!.

check('yes').	% declaring all the possible responses
check('y').
check('no').
check('n').

genrechoice(X):-	% gathering user input for genre selection
	write('What is your favourite game genre?'),nl,
	read(X).

writelist([L | Lt]):-	% displaying the games list
	write(L),
	nl,
	writelist(Lt), nl.

writelist([]).

/* Data Gathering */

question('Do you want to play a multiplayer game?',multiplayer).
question('Is graphics more important than game play?',aesthetic).
question('Do you like story games?',storyline).
question('Would you want guns?',shooter).
question('Do you like world building?',simulation).
question('Would you want to explore a new world?',adventure).
question('Are you using PlayStation?',playstation).
question('Are you using Switch?',switch).
question('Are you using Xbox?',xbox).
question('Do you want a challenge?',strategy).
question('Do you want to play a sports game?',sport).
question('Are you tough to scare?',horror).
question('Would you want to be a super hero?',superhero).

/* Knowledge Base */

genrelist(casual, ['fifa','minecraft','call of duty','farm sim','the sims','super mario bros','mario kart','civ v']).	% declaring all the genres
genrelist(competitive, ['fifa','call of duty','nba','mario kart','football manager']).
genrelist(storyline, ['spiderman','last of us','tomb raider','assassins creed','outlast','the walking dead','uncharted','gta','batman arkham']).
genrelist(racing, ['mario kart','grand turismo']).
genrelist(horror, ['outlast','the walking dead']).
genrelist(sport, ['fifa','grand turismo','nba','football manager']).
genrelist(adventure, ['zelda','uncharted','minecraft','tomb raider','forest']).
genrelist(fantasy, ['zelda','hades','elder scrolls']).
genrelist(superhero, ['spiderman','batman arkham']).
genrelist(survival, ['minecraft','forest','uncharted']).
genrelist(simulation, ['civ v','farm sim','the sims']).
genrelist(rpg, ['gta','hades','elder scrolls']).
genrelist(strategy, ['civ v','hades','football manager','zelda']).
genrelist(multiplayer, ['fifa','minecraft','call of duty','gta','mario kart','civ v']).

/* Rules */

rule(spider):-	% each declaring a game to recommend
	genre(storyline), genre(playstation), genre(superhero), (genre(adventure); genre(aesthetic)),not(genre(xbox); genre(switch)).
rule(cod):-
	genre(multiplayer),genre(shooter), (genre(xbox); genre(playstation)),not(genre(switch)).
rule(fifa):-
	genre(multiplayer),genre(sport),(genre(xbox);genre(playstation);genre(switch)).
rule(minecraft):-
	genre(adventure),genre(simulation), (genre(xbox);genre(playstation);genre(switch)).
rule(outlast):-
	genre(horror),genre(storyline), (genre(xbox);genre(playstation)), not(genre(switch)).
rule(zelda):-
	genre(adventure),genre(strategy),genre(switch),genre(aesthetic).
rule(uncharted):-
	genre(storyline),genre(shooter),genre(adventure),genre(playstation),genre(aesthetic),not(genre(xbox); genre(switch)).
rule(halo):-
	genre(multiplayer),genre(shooter),genre(xbox), not(genre(playstation); genre(switch)).
rule(lastofus):-
	genre(storyline),genre(shooter),genre(aesthetic),genre(adventure); genre(horor), not(genre(xbox); genre(switch)).
rule(unknown).

/* Recommendations */

recommendation(spider,'Spider Man').	% writting the actual recommendations
recommendation(cod,'Call of Duty').
recommendation(fifa,'Fifa').
recommendation(minecraft,'Minecraft').
recommendation(outlast,'Outlast').
recommendation(zelda,'Zelda').
recommendation(uncharted,'Uncharted').
recommendation(halo,'Halo').
recommendation(lastofus,'Last of Us').
recommendation(unknown,'No Match! Try Again!').
