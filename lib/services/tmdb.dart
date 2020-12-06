import 'dart:developer';

import 'package:desafio/services/network.dart';

const apiKey = '16cace569e383bf7a931d4dd51c5b07c';
const baseUrl = 'https://api.themoviedb.org/3';

class MovieService {

  Future<dynamic> getList() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$baseUrl/movie/top_rated?api_key=$apiKey&&language=pt-BR');

    var movies = await networkHelper.getData();
    return movies;
  } 

  Future<dynamic> getMovieByName(String movieName) async {
    var url = '$baseUrl/search/movie?api_key=$apiKey&&language=pt-BR&query=$movieName';
    log(url);
    NetworkHelper networkHelper = NetworkHelper(url);

    var movies = await networkHelper.getData();
    return movies;
  } 

  Future<dynamic> getDetails(String movieId) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$baseUrl/movie/$movieId?api_key=$apiKey&&language=pt-BR');

    var movieDetails = await networkHelper.getData();
    return movieDetails;
  }  
  
  String getMovieUrl(String movieImageId) {    
    return 'https://image.tmdb.org/t/p/w185$movieImageId';
  }  
}