import '../../utils/objects.dart';

class TopRatedMoviesModel {
  TopRatedMoviesModel({
      this.page, 
      this.topRatedMoviesList,
      this.totalPages, 
      this.totalResults,});

  TopRatedMoviesModel.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      topRatedMoviesList = [];
      json['results'].forEach((v) {
        topRatedMoviesList?.add(TopRatedMovie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  num? page;
  List<TopRatedMovie>? topRatedMoviesList;
  num? totalPages;
  num? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (topRatedMoviesList != null) {
      map['results'] = topRatedMoviesList?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

}

class TopRatedMovie extends Movie{
  TopRatedMovie({
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
      this.voteCount,});

  TopRatedMovie.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  @override
  bool? adult;
  @override
  String? backdropPath;
  @override
  List<num>? genreIds;
  @override
  num? id;
  @override
  String? originalLanguage;
  @override
  String? originalTitle;
  @override
  String? overview;
  @override
  num? popularity;
  @override
  String? posterPath;
  @override
  String? releaseDate;
  @override
  String? title;
  @override
  bool? video;
  @override
  num? voteAverage;
  @override
  num? voteCount;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

}