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

  void add(dynamic item) {
    setState(() {
      widget.movies.add(item);
    });
  }

  Future loadMovies() async{
    var result = await movieService.getList();
    log(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    loadMovies();
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
            return _body();
          }),
    );
  }

  _body() {
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
                        "https://www.comboinfinito.com.br/principal/wp-content/uploads/2017/12/Hunter-x-Hunter.jpg"),
                    ButtonTheme.bar(
                        child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Center(
                              child: const Text('Teste',
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
