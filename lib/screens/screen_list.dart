
import 'dart:developer';
import 'dart:ffi';
import 'package:desafio/screens/screen_details.dart';
import 'package:desafio/services/tmdb.dart';
import 'package:flutter/material.dart';

// Declaração da classe
class Challenge extends StatefulWidget {
  var movies = []; // Declaração da variável que vai receber os filmes
  var filterByName = false; // Variável que define o tipo de filtro

  @override
  _State createState() => _State(); //criação do state
}


class _State extends State<Challenge> {
  get child => null;

  // Cria uma instancia do movieService
  MovieService movieService = MovieService();

  // Método que retorna o ano de uma data
  int getYear(String data) {
    var newDate = data.split("-"); // split separa a string através do "-"
    return int.parse(newDate[0]); 
  }

  // Método que alterna entre os filtros
  void alterFilter() {        
    if(widget.filterByName) {
      widget.filterByName = false;// Ordem por data de lançamento
    } else {
      widget.filterByName = true;// Ordem alfabetica
    }
  }
  

// Método que carrega os filmes topRated
  Future loadMovies() async {
    var result = await movieService.getList();
    for (var item in result['results']) {
      setState(() {
        widget.movies.add(item);
      });
    }
  }
  
  // Método que busca um filme 
  Future searchMovie(String movieName) async {
    var result = await movieService.getMovieByName(movieName);
    setState(() {
      widget.movies.clear();
    });

    List<dynamic> tmdbResult = result['results'];

    log(tmdbResult.toString());

    if (!widget.filterByName) {
      // Ordernar por data de lançamento decrescente
      tmdbResult.sort((b, a) =>
        getYear(a['release_date']).compareTo(getYear(b['release_date'])));

      // Ordernar por data de lançamento crescente
      //tmdbResult.sort((b, a) => getYear(a['release_date']).compareTo(getYear(b['release_date'])));

    } else {
      // Ordernar por titulo
      tmdbResult.sort((a, b) => a['original_title'].compareTo(b['original_title']));
    }
    
    

    for (var item in tmdbResult) {
      setState(() {
        widget.movies.add(item);
      });
    }
  }

  @override
  void initState() {
    loadMovies();
  }
// Pagina inicial 
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
              child: ListView.builder(//Define que o conteudo é uma lista
                  itemCount: widget.movies.length,// Quantidade de items da lista 
                  itemBuilder: (BuildContext ctxt, int index) {// Inicia lista 
                    final movie = widget.movies[index];// Seleciona o filme atual da lista atraves do index
                    return _card(// Para cada item da lista é renderizado um Card
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

  // Renderização dos cards
  _card(String name, String imageId, String resumo, String datalancamento,
      dynamic avaliacao) {
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
                        FlatButton(// Torna o titulo do filme clicável 
                          child: Center(
                              child: Text(name,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white))),
                          onPressed: () { // Ao clicar no titulo do filme , é redirecinado para uma nova pagina de detalhes
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

// Renderização da barra de pesquisa 
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
                suffixIcon: IconButton(
                      icon: Icon(Icons.bar_chart),// Botão para selecionar o tipo de ordem dos filmes 
                      onPressed: () {
                        alterFilter();
                      }),
                hintText: 'Informe o filme que deseja...'),                
          ),
        ],
      ),
    );
  }
}
