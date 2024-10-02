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

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      backdropPath: json['backdrop_path'],
      genreIds:
          json['genre_ids'] == null ? null : json['genre_ids'].cast<num>(),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  dynamic toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
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
    while (movies.isNotEmpty) {
      pop();
    }
  }
}
