class MoviesGenresModel {
  MoviesGenresModel({
      this.genres,});

  MoviesGenresModel.fromJson(dynamic json) {
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(MoviesGenres.fromJson(v));
      });
    }
  }
  List<MoviesGenres>? genres;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MoviesGenres {
  MoviesGenres({
      this.id, 
      this.name,});

  MoviesGenres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}