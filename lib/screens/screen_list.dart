import 'dart:developer';
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

  Future loadMovies() async {
    var result = await movieService.getList();
    for (var item in result['results']) {
      setState(() {
        widget.movies.add(item);
      });
      log(item.toString());
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
      body: ListView.builder(
          itemCount: widget.movies.length,
          itemBuilder: (BuildContext ctxt, int index) {
            final movie = widget.movies[index];
            return _body(movie['title'], movie['poster_path']);
          }),
    );
  }

  _body(String name, String imageId) {
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
                    Image.network(
                        movieService.getMovieUrl(imageId)),
                    ButtonTheme.bar(
                        child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Center(
                              child: Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white))),
                          onPressed: () {
                            log("funciona");
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
}
