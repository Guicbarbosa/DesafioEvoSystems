import 'dart:developer';
import 'dart:ffi';
import 'package:desafio/screens/screen_details.dart';
import 'package:desafio/services/tmdb.dart';
import 'package:flutter/material.dart';

class Challenge extends StatefulWidget {
  var movies = [];
  @override
  _State createState() => _State();
}

class _State extends State<Challenge> {
  get child => null;

  MovieService movieService = MovieService();

  int getYear(String data) {
    var newDate = data.split("-");
    return int.parse(newDate[0]);
  }

  Future loadMovies() async {
    var result = await movieService.getList();
    for (var item in result['results']) {
      setState(() {
        widget.movies.add(item);
      });
      //log(item.toString());
    }
  }

  Future searchMovie(String movieName) async {
    var result = await movieService.getMovieByName(movieName);
    setState(() {
      widget.movies.clear();
    });

    List<dynamic> tmdbResult = result['results'];

    log(tmdbResult.toString());

    // ordernar por data de lançamento decrescente
    tmdbResult.sort((b, a) =>
        getYear(a['release_date']).compareTo(getYear(b['release_date'])));

    // Ordernar por data de lançamento crescente
    //tmdbResult.sort((b, a) => getYear(a['release_date']).compareTo(getYear(b['release_date'])));

    // Ordernar por titulo
    //tmdbResult.sort((a, b) => a['original_title'].compareTo(b['original_title']));

    for (var item in tmdbResult) {
      setState(() {
        widget.movies.add(item);
      });
      //log(item.toString());
    }
  }

  @override
  void initState() {
    loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Desafio'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            search(),
            new Expanded(
              child: ListView.builder(
                  itemCount: widget.movies.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final movie = widget.movies[index];
                    return _card(
                        movie['title'],
                        movie['poster_path'],
                        movie['overview'],
                        movie['release_date'],
                        movie['vote_average']);
                  }),
            )
          ],
        ));
  }

  _card(String name, String imageId, String resumo, String datalancamento,
      double avaliacao) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.black,
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Image.network(movieService.getMovieUrl(imageId)),
                    ButtonTheme.bar(
                        child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Center(
                              child: Text(name,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(name, imageId,
                                        resumo, datalancamento, avaliacao)));
                          },
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding search() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            onSubmitted: (value) => searchMovie(value),
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search),
                hintText: 'Informe o filme que deseja...'),
          ),
        ],
      ),
    );
  }
}
