import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class MovieDetail extends StatefulWidget {
  final movie;
  final filePath;
  final favoriteMovies;
  var inWatchList;

  MovieDetail(this.movie, this.filePath, this.favoriteMovies, this.inWatchList);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Color mainColor = const Color.fromARGB(255, 103, 103, 105);

  void toggleFavorite() {
    if (widget.favoriteMovies.contains(widget.movie['name'])) {
      widget.favoriteMovies.remove(widget.movie['name']);
      setState(() {
        widget.inWatchList = false;
      });
    } else {
      widget.favoriteMovies.add(widget.movie['name']);
      setState(() {
        widget.inWatchList = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMovies.contains(widget.movie['name'])) {
      setState(() {
        widget.inWatchList = true;
      });
    } else {
      setState(() {
        widget.inWatchList = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 173, 172, 172),
        leading: BackButton(
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          widget.filePath,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                          image: DecorationImage(
                              image: AssetImage(widget.filePath),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: mainColor,
                                blurRadius: 5.0,
                                offset: const Offset(2.0, 5.0))
                          ],
                        ),
                        child: const SizedBox(
                          width: 100.0,
                          height: 149.0,
                        ),
                      ),
                    ),
                    //Column(
                    //children: [
                    Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: Text(
                                          widget.movie['name'], //title
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'Arvo',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: RichText(
                                              text: TextSpan(
                                                  style:
                                                      const TextStyle(), //apply style to all
                                                  children: [
                                                TextSpan(
                                                    text:
                                                        '${widget.movie['rating']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    )),
                                                const TextSpan(
                                                    text: '/10',
                                                    style: TextStyle(
                                                      //fontSize: 25,
                                                      color: Color.fromARGB(
                                                          255, 160, 160, 191),
                                                    )),
                                              ]))),
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(12.0)),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: 110, // <-- Your width
                                      height: 20, // <-- Your height
                                      child: ElevatedButton(
                                        onPressed: () {
                                          toggleFavorite();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: widget.inWatchList
                                              ? const Text(
                                                  'REMOVE FROM WATCHLIST',
                                                  style: TextStyle(fontSize: 6),
                                                )
                                              : const Text(
                                                  '+ ADD TO WATCHLIST',
                                                  style: TextStyle(fontSize: 6),
                                                ),
                                        ),
                                      )),
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: 110,
                                      height: 20,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          var url = widget.movie['trailer'];
                                          final uri = Uri.parse(url);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Text(
                                            'WATCH TRAILER',
                                            style: TextStyle(fontSize: 6),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ))),
                  ],
                ),
                //horizontal divider
                Container(
                  width: 3200.0,
                  height: 0.75,
                  color: const Color(0xD2D2E1ff),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Short description',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Padding(padding: EdgeInsets.all(2.0)),
                    Text(
                      widget.movie['synopsis'],
                      maxLines: 3,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 160, 160, 191),
                          fontFamily: 'Arvo'),
                    )
                  ],
                ),
                //horizontal divider
                Container(
                  width: 3200.0,
                  height: 0.75,
                  color: const Color(0xD2D2E1ff),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Details',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Padding(padding: EdgeInsets.all(2.0)),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: const Text('Genre:',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 160, 160, 191),
                                  fontFamily: 'Arvo',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              ' ${widget.movie['genre']}',
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 160, 160, 191),
                                  fontFamily: 'Arvo'),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: const Text('Released Date:',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 160, 160, 191),
                                  fontFamily: 'Arvo',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Text(' ${widget.movie['releaseDate']}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 160, 160, 191),
                                      fontFamily: 'Arvo'),
                                  textAlign: TextAlign.left)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
