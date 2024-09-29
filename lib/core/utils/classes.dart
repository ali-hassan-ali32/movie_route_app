import '../models/movie_details/movie_details_model.dart';

class Movie {
  bool? adult;
  String? backdropPath;
  List<num>? genreIds;
  num? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;
}

class MoviesStack {
  List<MovieDetailsModel> movies = [];

  MoviesStack() {
    movies = [];
  }

  void push(MovieDetailsModel movie) {
    movies.add(movie);
  }

  MovieDetailsModel? pop() {
    if (movies.isNotEmpty) {
      return movies.removeLast();
    }
    return null;
  }

  MovieDetailsModel? peek() {
    if (movies.isNotEmpty) {
      return movies.last;
    }
    return null;
  }

  bool isEmpty() {
    return movies.isEmpty;
  }

  void clear() {
    while(movies.isNotEmpty) {
      pop();
    }
  }
}