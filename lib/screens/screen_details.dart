import 'dart:developer';
import 'dart:ffi';
import 'package:desafio/services/tmdb.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String name;
  String imageId;
  String resumo;
  String datalancamento;
  double avaliacao;

  //Injeção de dependencia - Construtor
  Details(name, imageId, resumo, datalancamento, avaliacao) {
    this.name = name;
    this.imageId = imageId;
    this.resumo = resumo;
    this.datalancamento = datalancamento;
    this.avaliacao = avaliacao;
  }

  @override
  _State createState() => _State();
}

class _State extends State<Details> {
  get child => null;

  MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: _body(),
    );
  }

  String convertData(String data) {
    var newDate = data.split("-");
    var day = newDate[2];
    var month = newDate[1];
    var year = newDate[0];
    return '$day/$month/$year';
  }

  _body() {
    var datalancamento = convertData(widget.datalancamento);
    var avaliacao = widget.avaliacao;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.black,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Image.network(movieService.getMovieUrl(widget.imageId)),
                    Text(widget.name,
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    Text(widget.resumo,
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    Text('\n Data de Lançamento : $datalancamento ',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    Text('Avaliação : $avaliacao',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
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
