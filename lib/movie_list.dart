import 'dart:core';
import 'package:flutter/material.dart';
import 'movie_detail.dart';

enum SortBy { name, date }

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  MovieListState createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  Color mainColor = const Color(0xff3C3261);

  var moviesNew = [
    {
      "name": 'Avengers: Age of Ultron',
      "duration": '2h 21min',
      "genre": 'Action, Adventure, Sci-Fi',
      "rating": '7.3',
      "trailer": 'https://www.youtube.com/watch?v=tmeOjFno6Do',
      "synopsis":
          'When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it\'s up to Earth\'s mightiest heroes to stop the villainous Ultron from enacting his terrible plan.',
      "releaseDate": '2015, 1 May'
    },
    {
      "name": 'Guardians of the Galaxy ',
      "duration": '2h 1min',
      "genre": 'Action, Adventure, Comedy',
      "rating": '8.0',
      "trailer": 'https://www.youtube.com/watch?v=d96cjJhvlMA',
      "synopsis":
          'A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.',
      "releaseDate": '2014, 1 August'
    },
    {
      "name": 'Knives Out',
      "duration": '2h 10min',
      "genre": 'Comedy, Crime, Drama',
      "rating": '7.9',
      "trailer": 'https://www.youtube.com/watch?v=qGqiHJTsRkQ',
      "synopsis":
          'A detective investigates the death of a patriarch of an eccentric, combative family.',
      "releaseDate": '2019, 27 November'
    },
    {
      "name": 'Spider-Man: Into the Spider-Verse',
      "duration": '1h 57min',
      "genre": 'Action, Animation, Adventure',
      "rating": '8.4',
      "trailer": 'https://www.youtube.com/watch?v=tg52up16eq0',
      "synopsis":
          'Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.',
      "releaseDate": '2018, 14 December'
    },
    {
      "name": 'Tenet',
      "duration": '2h 30 min',
      "genre": 'Action, Sci-Fi',
      "rating": '7.8',
      "trailer": 'https://www.youtube.com/watch?v=LdOM0x0XDMo',
      "synopsis":
          'Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.',
      "releaseDate": '2020, 3 September'
    },
  ];

  var filePaths = [
    'assets/images/Avengers.png',
    'assets/images/GuardiansofTheGalaxy.png',
    'assets/images/KnivesOut.png',
    'assets/images/SpiderMan.png',
    'assets/images/Tenet.png',
  ];

  var filePathsDate = [
    'assets/images/GuardiansofTheGalaxy.png',
    'assets/images/Avengers.png',
    'assets/images/SpiderMan.png',
    'assets/images/KnivesOut.png',
    'assets/images/Tenet.png',
  ];

  var favoriteMovies = <String>[];
  var releaseYear = '';
  bool inWatchList = false;

  SortBy? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 173, 172, 172),
        automaticallyImplyLeading: false,
        elevation: 0.3,
        actions: <Widget>[
          PopupMenuButton<SortBy>(
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (SortBy item) {
              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortBy>>[
              const PopupMenuItem<SortBy>(
                value: SortBy.name,
                child: Text('Sort by Title'),
              ),
              const PopupMenuItem<SortBy>(
                value: SortBy.date,
                child: Text('Sort by Release Date'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieTitle(mainColor),
            Expanded(
              child: ListView.builder(
                  itemCount: moviesNew == null ? 0 : moviesNew.length,
                  itemBuilder: (context, i) {
                    if (selectedMenu == SortBy.name) {
                      //sort by name
                      moviesNew.sort((a, b) =>
                          (a["name"] ?? '').compareTo(b["name"] ?? ''));
                      String? releaseDate = moviesNew[i]["releaseDate"];
                      String releaseYear = releaseDate!.split(", ")[0];

                      return Column(children: [
                        TextButton(
                          child: MovieCell(moviesNew, releaseYear, i, filePaths,
                              favoriteMovies),
                          //padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MovieDetail(moviesNew[i], filePaths[i],
                                  favoriteMovies, inWatchList);
                            })).then((_) => setState(() {}));
                          },
                          //color: Colors.white,
                        ),
                        Container(
                          width: 300.0,
                          height: 0.75,
                          color: const Color.fromARGB(210, 144, 169, 219),
                          margin: const EdgeInsets.only(top: 0.0),
                        )
                      ]);
                    } else {
                      //sort by date
                      moviesNew.sort((a, b) => (a["releaseDate"] ?? '')
                          .compareTo(b["releaseDate"] ?? ''));
                      String? releaseDate = moviesNew[i]["releaseDate"];
                      String releaseYear = releaseDate!.split(", ")[0];

                      return Column(children: [
                        TextButton(
                          child: MovieCell(moviesNew, releaseYear, i,
                              filePathsDate, favoriteMovies),
                          //padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MovieDetail(moviesNew[i], filePathsDate[i],
                                  favoriteMovies, inWatchList);
                            })).then((_) => setState(() {}));
                          },
                          //color: Colors.white,
                        ),
                        Container(
                          width: 300.0,
                          height: 0.75,
                          color: const Color.fromARGB(210, 144, 169, 219),
                          margin: const EdgeInsets.only(top: 0.0),
                        )
                      ]);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;

  const MovieTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: Text(
        'Movies',
        style: TextStyle(
            fontSize: 36.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCell extends StatefulWidget {
  final moviesNew;
  final releaseYear;
  final i;
  final filePaths;
  var favoriteMovies;

  MovieCell(this.moviesNew, this.releaseYear, this.i, this.filePaths,
      this.favoriteMovies);

  @override
  MovieCellState createState() {
    return MovieCellState();
  }
}

class MovieCellState extends State<MovieCell> {
  Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage(widget.filePaths[widget.i]),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: const Offset(2.0, 5.0))
                  ],
                ),
                child: Container(
                  width: 80.0,
                  height: 120.0,
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.moviesNew[widget.i]["name"]} (${widget.releaseYear})', //title
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 4.0)),
                  Text(
                    '${widget.moviesNew[widget.i]["duration"]} - ${widget.moviesNew[widget.i]["genre"]}', // runtime and genre
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff8785A4),
                        fontFamily: 'Arvo'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 28.0)),
                  Container(
                      child: widget.favoriteMovies
                              .contains(widget.moviesNew[widget.i]["name"])
                          ? const Text(
                              'ON MY WATCHLIST',
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 8.0,
                                  color: Color.fromARGB(255, 64, 63, 78),
                                  fontFamily: 'Arvo'),
                            )
                          : const Text(''))
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }
}
